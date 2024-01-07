Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682D913FE1
	for <linux-ide@vger.kernel.org>; Sun,  7 Jan 2024 18:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thesusis.net
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id 9BF1415231D; Sun,  7 Jan 2024 13:03:01 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Phillip Susi <phill@thesusis.net>
Subject: [PATCH 0/3] Let sleeping disks lie
Date: Sun,  7 Jan 2024 13:02:55 -0500
Message-Id: <20240107180258.360886-1-phill@thesusis.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87msthdo11.fsf@vps.thesusis.net>
References: <87msthdo11.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches attempt to help disks that are spun down stay that way,
until they are actually accessed.  The first patch deals with disks in
SLEEP mode ( hdparm -Y ).  SLEEP mode is a lower power mode than
STANDBY.  Linux has had support for it for a long time, however, if
you try to make use of it, you quickly find that the disk wakes up for
no apparent reason.  This is because in SLEEP mode, the disk
electronics are powered off so that it can not respond to any command.
Waking the disk up requires a SATA link reset.  There are a number of
commands that are regularly issued to a disk in standby that the disk
treats as a NOOP, but in SLEEP mode, these commands trigger the SATA
link reset to wake up the drive in order to send the command to the
drive.  This patch deals with this by completing the commands in
libata rather than waking the drive.

The third patch is about how system suspend/resume effects disks in
standby.  Archive disks that are very rarely accessed may spend most
of their lives in standby, but every time the system is suspended and
resumed, they spin up, only to be spun back down again.  This wastes
power and puts wear and tear on the drive that is not neccesary.  ATA
drives have a feature called Power Up In Standby that allows the drive
to not automatically spin up when the system is resumed.

There are two different types of PuiS: one that acts like regular
standby, in that any command that requires access to the disk will
automatically spin the disk up, and another that requires an explicit
SET FEATURES command to bring it out of PuiS mode.  The kernel used to
let the former type remain in standby after system resume, but recent
changes have changed that behavior.  This patch attempts to allow both
types to remain spun down after system resume, until they are actually
accessed.

It currently has two paths for doing so.  The one that is currently
active is to simply set the ATA_DFLAG_SLEEPING flag and leave the
drive in standby mode.  This flag causes a later attempt to access the
drive to trigger a round of EH that resets the SATA link, revalidates
the drive, and if needed, issude the SET FEATURES command to bring it
out of PuiS mode.  The alternative path ( currently #if 0'd out )
actually issues the SLEEP command to put the drive into SLEEP mode.
This can possibly save a little more power than leaving it in standby
mode, but the transition from standby to sleep may not be legal
according ot the ATA standards.  This therefore, may upset some drives
( though it works fine with mine ).  It therefore is not suitable as a
default.

I am thinking of adding a sysfs knob to control the PuiS behavior with
3 states:

0: wake the disk anyhow ( current behavior )
1: leave the disk in standby mode
2: put the disk to SLEEP

I think the worst thing that can happen with the third option is that
some disks might error and you will get some clutter in your syslog
while EH happens.  People can try this option and fall back to #1 if
they encounter issues.  Otherwise, they can enjoy the added power
savings.

Finally, the second patch addresses an issue where the third patch's
clearing of the SET_ACTIVE flag was countermanded.  This was because
the flag is set every time the EH starts during system resume.  In my
case, putting the drive to SLEEP caused a second round of EH to happen
as the SATA PHY is shut down during SLEEP.  That turned on the
SET_ACTIVE flag again, causing a VERIFY command to try to start the
drive, which failed because the drive requires the SET FEATURES
command to come out of PuiS mode.

Phillip Susi (3):
  libata: avoid waking disk for several commands
  libata: only wake a drive once on system resume
  libata: don't start PuiS disks on resume

 drivers/ata/libata-core.c | 61 ++++++++++++++++++++++++++++++++++-----
 drivers/ata/libata-eh.c   | 20 +++++++++----
 drivers/ata/libata.h      |  3 +-
 include/linux/libata.h    |  1 +
 4 files changed, 70 insertions(+), 15 deletions(-)

-- 
2.30.2


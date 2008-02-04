From: Borislav Petkov <petkovbb@googlemail.com>
Subject: (unknown)
Date: Mon,  4 Feb 2008 14:40:18 +0100
Message-ID: <1202132440-26648-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755869AbYBDNm0@vger.kernel.org>
Subject: 
Sender: linux-kernel-owner@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi Bart,

here are the pending ide-tape patches reworked which incorporate all review
points raised so far. Several new patches are appended to the original series
which i thought would be reasonable to sumbit along with the others. Also,
i've applied "ide-tape: dump gcw fields on error in idetape_identify_device()"
which is #12 and which you can simply ignore. Furthermore, #32 from the original
series got split up into the different logical changes it dealt with, as you
requested.


 Documentation/feature-removal-schedule.txt |   14 +-
 drivers/ide/ide-tape.c                     | 2764 +++++++++++++---------------
 2 files changed, 1325 insertions(+), 1453 deletions(-)

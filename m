From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: improve ATA ACPI support, take#2
Date: Sat, 5 May 2007 23:50:37 +0900
Message-ID: <11783766373569-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: 
Sender: linux-acpi-owner@vger.kernel.org
To: jeff@garzik.org, mjg59@srcf.ucam.org, rdunlap@xenotime.net, alan@lxorguk.ukuu.org.uk, forrest.zhao@gmail.com, lenb@kernel.org, linux-acpi@vger.kernel.org, hare@suse.de, linux-ide@vger.kernel.org, htejun@gmail.com
List-Id: linux-ide@vger.kernel.org

Hello, all.

This is the second take of improve-ATA-ACPI-support patchset.  Changes
from the last take[L] are...

* s/atadev/dev/
* s/do_drive_get_GTF/ata_dev_get_GTF/
* s/do_drive_set_taskfiles/ata_dev_set_taskfiles/

As I wrote in the previous thread, I don't think automatically
matching ACPI nodes to ATA ports and devices is a good idea or can be
done safely, so I left that part alone.  If you've got better ideas,
be my guest.  But with or without it, this patchset fixes a whole
bunch of problem and makes ATA ACPI support sane.  For more info,
please read the following message.

  http://article.gmane.org/gmane.linux.ide/17554

This patchset is against...

  libata-dev#upstream(225036314e768bbfe8331ea9b0e91ca101afe427)
  + [1] libata-acpi-fix-GTF-command-protocol-for-ATAPI

Thanks.

--
tejun

[L] http://thread.gmane.org/gmane.linux.ide/18127
[1] http://article.gmane.org/gmane.linux.ide/18122


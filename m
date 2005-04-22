From: Rommer <rommer@active.by>
Subject: sata_sil.c bugfix
Date: Sat, 23 Apr 2005 02:12:19 +0300
Message-ID: <426984D3.3080204@active.by>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from us401.activeby.net ([216.32.91.22]:21903 "EHLO
	us401.activeby.net") by vger.kernel.org with ESMTP id S261288AbVDVXLo
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Apr 2005 19:11:44 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hello,

I have some troubles with my Adapdec AAC-1210SA;
Configuration:
Adaptec AAC-1210SA SATA controller,
2 HDD Seagate Barracuda 7 120G (ST3120827AS)
Fedora Core 3, kernel 2.6.11.7 without any patches

During about month all works fine, but now I created Software RAID1:
md0 (sd[ab]1) - /boot, md1 (sd[ab]2) - /

When I ran
mkadm /dev/md1 --fail /dev/sda3
mkadm /dev/md1 --remove /dev/sda3
all was ok, but after
mkadm /dev/md1 --add /dev/sda3
(when /dev/sda3 adding to /dev/md1 at speed ~ 50-60 Mb/sec)
I got these errors:
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: error=0x04 { DriveStatusError }
and sometimes also
ata1: command 0x35 timeout, stat 0xd9 host_stat 0x1
ata1: status=0xd9 { Busy }
Current sda: sense key Recovered Error
ASC=86 ASCQ=42
ATA: abnormal status 0xD9 on port 0x4281A087
ATA: abnormal status 0xD9 on port 0x4281A087
ATA: abnormal status 0xD9 on port 0x4281A087
...

But sda3 works fine, because
mke2fs -j /dev/sda3
e2fsck -cv /dev/sda3
reported no bad sectors

When I remove sdb3 from md1, and after add it to md1, I have the same errors
for ata2 or sdb.

I found in sata_sil.c code:
/* TODO firmware versions should be added - eric */
struct sil_drivelist {
	const char * product;
	unsigned int quirk;
} sil_blacklist [] = {
	{ "ST320012AS",		SIL_QUIRK_MOD15WRITE },
	{ "ST330013AS",		SIL_QUIRK_MOD15WRITE },
	{ "ST340017AS",		SIL_QUIRK_MOD15WRITE },
	{ "ST360015AS",		SIL_QUIRK_MOD15WRITE },
	{ "ST380013AS",		SIL_QUIRK_MOD15WRITE },
	{ "ST380023AS",		SIL_QUIRK_MOD15WRITE },
	{ "ST3120023AS",	SIL_QUIRK_MOD15WRITE },
	{ "ST3160023AS",	SIL_QUIRK_MOD15WRITE },
	{ "ST3120026AS",	SIL_QUIRK_MOD15WRITE },
	{ "ST3200822AS",	SIL_QUIRK_MOD15WRITE },
	{ "ST340014ASL",	SIL_QUIRK_MOD15WRITE },
	{ "ST360014ASL",	SIL_QUIRK_MOD15WRITE },
	{ "ST380011ASL",	SIL_QUIRK_MOD15WRITE },
	{ "ST3120022ASL",	SIL_QUIRK_MOD15WRITE },
	{ "ST3160021ASL",	SIL_QUIRK_MOD15WRITE },
	{ "Maxtor 4D060H3",	SIL_QUIRK_UDMA5MAX },
	{ }
};
I added my ST3120827AS as { "ST3120827AS", SIL_QUIRK_MOD15WRITE },
rebuilt kernel and made reboot.

With new kernel raid1 reconstruction works at speed ~ 15-20 Mb/sec with load
average ~2, but without errors. May be ST3120827AS must be blacklisted too?

Also I found this code in siimage.c (old driver for AAC-1210SA):
static int is_dev_seagate_sata(ide_drive_t *drive)
{
	const char *s = &drive->id->model[0];
	unsigned len;

	if (!drive->present)
		return 0;

	len = strnlen(s, sizeof(drive->id->model));

	if ((len > 4) && (!memcmp(s, "ST", 2))) {
		if ((!memcmp(s + len - 2, "AS", 2)) ||
		    (!memcmp(s + len - 3, "ASL", 3))) {
			printk(KERN_INFO "%s: applying pessimistic Seagate "
					 "errata fix\n", drive->name);
			return 1;
		}
	}
	return 0;
}
May be all Seagate SATA hard drives must be blacklisted in sata_sil.c ?

--
Roman Shishnev,
Active.BY support
----------------------------------
http://www.active.by/
phone +375(29)7785132, ICQ: 372800


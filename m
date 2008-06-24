From: Felix Miata <mrmazda@ij.net>
Subject: Re: [RFC] Separating out libata out of SCSI (finally)
Date: Tue, 24 Jun 2008 11:42:22 -0400
Message-ID: <486115DE.20805@ij.net>
References: <485B2CC6.6070201@kernel.org>	 <1213993737.3443.35.camel@localhost.localdomain>	 <485C31FE.8050408@garzik.org>	 <87f94c370806231404t13586777x7f7bee24ebe25ffc@mail.gmail.com>	 <1214255460.3310.27.camel@localhost.localdomain>	 <4860B099.2030305@panasas.com> <1214318550.3299.7.camel@localhost.localdomain> <48610BDC.6090101@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pop-knobcone.atl.sa.earthlink.net ([207.69.195.64]:50431 "EHLO
	pop-knobcone.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750770AbYFXPmK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jun 2008 11:42:10 -0400
Received: from user-142grnk.cable.mindspring.com ([72.40.110.244] helo=[192.168.0.51])
	by pop-knobcone.atl.sa.earthlink.net with esmtp (Exim 3.36 #1)
	id 1KBAek-0004Ix-00
	for linux-ide@vger.kernel.org; Tue, 24 Jun 2008 11:42:06 -0400
In-Reply-To: <48610BDC.6090101@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On 2008/06/24 23:59 (GMT+0900) Tejun Heo apparently typed:

> I'm currently working on a scheme where partitions above gd->minors get
> allocated dynamic MAJ:MIN.  It looks like it can be done mostly in block
> layer proper.  The only problem I can foresee is not being able to
> specify MAJ:MIN as root device but that shouldn't be a major problem.
> I'll report back when I make more progress.

Please correct me if I'm wrong, but on the following, would it not
be a major problem booting, without deleting any existing or moving
any existing, with only a few more upgrade cycles to replace what's
there installed now with current and near future distros?

Disk /dev/hda: 160.0 GB, 160041885696 bytes
255 heads, 63 sectors/track, 19457 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Disk identifier: 0x31caf8da

   Device Boot Start    End    Blocks   Id  System
/dev/hda1          1     13    104391   17  Hidden HPFS/NTFS		# OS/2 maintenance OS
/dev/hda2   *     14     14      8032+   a  OS/2 Boot Manager		# Primary Boot Loader
/dev/hda3         15     46    257040    6  FAT16			# DOS
/dev/hda4         48  14594 116848777+   5  Extended		
/dev/hda5         48     48      8001    1  FAT12			# DOS
/dev/hda6         49     80    257008+   6  FAT16			# DOS
/dev/hda7         82    107    208813+  83  Linux			# primary Grub
/dev/hda8        108    222    923706   82  Linux swap / Solaris
/dev/hda9        223    834   4915858+  83  Linux			# Fedora, current
/dev/hda10      1142   1243    819283+   7  HPFS/NTFS			# OS/2 OS
/dev/hda11      1269   1523   2048256    7  HPFS/NTFS			# OS/2 data
/dev/hda12      1575   1693    955836    7  HPFS/NTFS			# OS/2 apps
/dev/hda13      1694   2012   2562336    7  HPFS/NTFS			# OS/2 archival
/dev/hda14      2014   2217   1638598+  83  Linux			# /home
/dev/hda15      2218   2568   2819376   83  Linux			# /Knoppix
/dev/hda16      2569   3486   7373803+  83  Linux			# SUSE 10.2 /
/dev/hda17      3487   4379   7172991   83  Linux			# /pub
/dev/hda18      4380   4409    240943+  83  Linux			# /srv
/dev/hda19      4410   4549   1124518+  83  Linux			# /usr/local
/dev/hda20      4550   5187   5124703+  83  Linux			# /usr/src
/dev/hda21      5188   5799   4915858+  83  Linux			# Mandriva 2007 /
/dev/hda22      5800   6513   5735173+  83  Linux			# Factory /
/dev/hda23      6514   7176   5325516   83  Linux			# Cooker /
/dev/hda24      7178   7279    819283+   7  HPFS/NTFS			# eComStation beta OS
/dev/hda25      7281   7892   4915858+  83  Linux			# Fedora 6 /
/dev/hda26      7893   8504   4915858+  83  Linux			# Fedora 5 /
/dev/hda27      8505   9116   4915858+  83  Linux			# SUSE 10.0 /
/dev/hda28      9117   9728   4915858+  83  Linux			# Mandriva 2006 /
/dev/hda29      9729  10340   4915858+  83  Linux			# Mandriva 2008 /
/dev/hda30     10341  10850   4096543+  83  Linux			# SUSE 11.0 /
/dev/hda31     12656  12757    819283+   7  HPFS/NTFS			# OS/2 skeleton
/dev/hda32     12758  14593  14747638+  83  Linux			# /isos
/dev/hda33     14594  14594      8001   12  Compaq diagnostics		# demarcation line
	       14595  19456						# freespace
-- 
"Where were you when I laid the earth's
foundation?"		       Matthew 7:12 NIV

 Team OS/2 ** Reg. Linux User #211409

Felix Miata  ***  http://fm.no-ip.com/

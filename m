From: "Jeroen Makkinje" <j.makkinje@xs4all.nl>
Subject: cat /proc/ide/ide1/hdc/identify hangs
Date: Wed, 10 Sep 2003 15:11:06 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <13755.80.126.29.72.1063199466.squirrel@webmail.xs4all.nl>
Reply-To: j.makkinje@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:19217 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id S263094AbTIJNLI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 Sep 2003 09:11:08 -0400
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


My problem is simple:

cat /proc/ide/ide1/hdc/identify
does hang in version linux.2.6.0-test5
but it does not hang in version
./linux.2.4.20-4GB that comes default
with SuSE 8.2.

cat /proc/ide/ide1/hdc/capacity sometimes
also hangs but not reproducable.

I have executed the script ./gen_err
(given below) to generate some information
while running each of the kernel version.

The output files are put in:
http://www.xs4all.nl/~makkij/error_report/


I did remove "hdc=ide-scsi" from
the grub conf file. This had no effect.

I hope you can assist me. Either to
fix the problem or to  generate more infor-
nation.

The original posting is posted to
linux-ide@vger.kernel.org

I have send a copy to Andi Kleen
He reported a similar problem
with subject "taskfile merge breaking suse hwscan"



==========
./gen_err:
==========

#!/bin/bash
rm -i *
dmesg > dmesg
(strace -v cat /proc/ide/ide1/hdc/identify ) &> strace_identify
(strace -v cat /proc/ide/ide1/hdc/capacity ) &> strace_capacity
cat /proc/ide/ide1/hdc/driver > driver
cat /proc/ide/ide1/hdc/media > media
cat /proc/ide/ide1/hdc/model > model
cat /proc/ide/ide1/hdc/settings > settings
sh
/home/jeroenm/Documents/kernels/linux-2.6.0-test4/scripts/ver_linux
> ver_linux
cat /proc/version > version
cat /proc/cpuinfo > cpuinfo
cat /proc/modules > modules
cat /proc/ioports > ioports
lspci -vvv > lspci
cat /proc/scsi/scsi > scsi
cat /boot/grub/menu.lst > bootloader
cat /proc/ide/sis > sis
cat /proc/ide/drivers > drivers



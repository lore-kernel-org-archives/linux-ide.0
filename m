From: Brett Russ <russb@emc.com>
Subject: libata-2.6 bk tree build problem
Date: Wed, 27 Oct 2004 16:37:29 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <41800709.6020808@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailhub.lss.emc.com ([168.159.2.31]:52879 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S262570AbUJ0Uhq
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 27 Oct 2004 16:37:46 -0400
Received: from [168.159.32.130] ([168.159.32.130])
	by mailhub.lss.emc.com (Switch-3.1.6/Switch-3.1.6) with ESMTP id i9RKbYrb023273
	for <linux-ide@vger.kernel.org>; Wed, 27 Oct 2004 16:37:35 -0400 (EDT)
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

steps to reproduce:

1) bk pull
2) make distclean
3) make menuconfig

gives me the following output:

   HOSTCC  scripts/basic/fixdep
   HOSTCC  scripts/basic/split-include
   HOSTCC  scripts/basic/docproc
   SHIPPED scripts/kconfig/zconf.tab.h
   HOSTCC  scripts/kconfig/conf.o
   HOSTCC  scripts/kconfig/mconf.o
   SHIPPED scripts/kconfig/zconf.tab.c
   SHIPPED scripts/kconfig/lex.zconf.c
   HOSTCC  -fPIC scripts/kconfig/zconf.tab.o
   HOSTLLD -shared scripts/kconfig/libkconfig.so
   HOSTLD  scripts/kconfig/mconf
   HOSTCC  scripts/lxdialog/checklist.o
   HOSTCC  scripts/lxdialog/inputbox.o
   HOSTCC  scripts/lxdialog/lxdialog.o
   HOSTCC  scripts/lxdialog/menubox.o
   HOSTCC  scripts/lxdialog/msgbox.o
   HOSTCC  scripts/lxdialog/textbox.o
   HOSTCC  scripts/lxdialog/util.o
   HOSTCC  scripts/lxdialog/yesno.o
   HOSTLD  scripts/lxdialog/lxdialog
scripts/kconfig/mconf arch/i386/Kconfig
drivers/media/dvb/Kconfig:34: can't open file 
"drivers/media/dvb/dibusb/Kconfig"
make[1]: *** [menuconfig] Error 1
make: *** [menuconfig] Error 2


Am I doing something wrong?

Thanks,
BR

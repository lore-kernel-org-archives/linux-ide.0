From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata-2.6 bk tree build problem
Date: Wed, 27 Oct 2004 17:19:25 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <418010DD.1060904@pobox.com>
References: <41800709.6020808@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64985 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262760AbUJ0VTk
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 27 Oct 2004 17:19:40 -0400
In-Reply-To: <41800709.6020808@emc.com>
List-Id: linux-ide@vger.kernel.org
To: Brett Russ <russb@emc.com>
Cc: linux-ide@vger.kernel.org

Brett Russ wrote:
> steps to reproduce:
> 
> 1) bk pull
> 2) make distclean
> 3) make menuconfig
> 
> gives me the following output:
> 
>   HOSTCC  scripts/basic/fixdep
>   HOSTCC  scripts/basic/split-include
>   HOSTCC  scripts/basic/docproc
>   SHIPPED scripts/kconfig/zconf.tab.h
>   HOSTCC  scripts/kconfig/conf.o
>   HOSTCC  scripts/kconfig/mconf.o
>   SHIPPED scripts/kconfig/zconf.tab.c
>   SHIPPED scripts/kconfig/lex.zconf.c
>   HOSTCC  -fPIC scripts/kconfig/zconf.tab.o
>   HOSTLLD -shared scripts/kconfig/libkconfig.so
>   HOSTLD  scripts/kconfig/mconf
>   HOSTCC  scripts/lxdialog/checklist.o
>   HOSTCC  scripts/lxdialog/inputbox.o
>   HOSTCC  scripts/lxdialog/lxdialog.o
>   HOSTCC  scripts/lxdialog/menubox.o
>   HOSTCC  scripts/lxdialog/msgbox.o
>   HOSTCC  scripts/lxdialog/textbox.o
>   HOSTCC  scripts/lxdialog/util.o
>   HOSTCC  scripts/lxdialog/yesno.o
>   HOSTLD  scripts/lxdialog/lxdialog
> scripts/kconfig/mconf arch/i386/Kconfig
> drivers/media/dvb/Kconfig:34: can't open file 
> "drivers/media/dvb/dibusb/Kconfig"
> make[1]: *** [menuconfig] Error 1
> make: *** [menuconfig] Error 2

Run "bk -r co -Sq" to check out files.

	Jeff




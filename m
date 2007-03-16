From: YUP <yupadmin@gmail.com>
Subject: Re: libata: CD and dvd devices not recognized
Date: Fri, 16 Mar 2007 23:37:24 +0100
Message-ID: <45FB1C24.1000502@gmail.com>
References: <45F873AC.6010204@gmail.com> <45F8C3E1.3080805@tw.ibm.com> <45F9460E.7020701@gmail.com> <45F98343.3060703@tw.ibm.com> <45FA6E8A.5070507@gmail.com> <45FAB270.8090909@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:54239 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965999AbXCPWhc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Mar 2007 18:37:32 -0400
Received: by nf-out-0910.google.com with SMTP id o25so420684nfa
        for <linux-ide@vger.kernel.org>; Fri, 16 Mar 2007 15:37:30 -0700 (PDT)
In-Reply-To: <45FAB270.8090909@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: linux-ide@vger.kernel.org

Hi Albert,

I think my cdrom drive is broken. I did some test under windows by means 
of nero-info tool and it shows that cdrom drive has not available 
read/write speed. Here is summary:

Nero InfoTool 4.2.1.0

Drive Information
------------------
Drive                      : HP       DVD Writer 200j
Type                       : DVD+R/RW Recorder
Firmware Version           : 1.36
Buffer Size                : 2 MB
Date                       : 02-07-24
Serial Number              : DA33 110484
Vendor Specific            :  020724
Drive Letter               : E:\
Location                   : 0:0
Mechanism                  : Tray
Read Speed                 : 32 , 20 , 12 , 10 , 8 , 4 , 2  X
Write Speed                : 12 , 8 , 4 , 2  X

Read CD Text               : Yes
Return C2 Pointers         : Yes
Read CD-R                  : Yes
Read CD-RW                 : Yes
Read DVD-ROM               : Yes
Read DVD-RAM               : No
Read DVD-R                 : No
Read DVD-RW                : No
Read DVD-R DL              : No
Read DVD+R                 : Yes
Read DVD+RW                : Yes
Read DVD+R DL              : No
Read BD-ROM                : No
Read BD-R                  : No
Read BD-RE                 : No
Read HD DVD-ROM            : No
Read HD DVD-R              : No
Read HD DVD-RW             : No
Read HD-BURN               : No
Read Digital Audio         : Yes
Read CD+G                  : Yes
Read VideoCD               : Yes

Write CD-R                 : Yes
Write CD-RW                : Yes
Write DVD-R                : No
Write DVD-RW               : No
Write DVD-R DL             : No
Write DVD+R                : Yes
Write DVD+RW               : Yes
Write DVD+R DL             : No
Write DVD-RAM              : No
Write BD-R                 : No
Write BD-RE                : No
Write HD DVD-R             : No
Write HD DVD-RW            : No
Write HD-BURN-R            : No
Write HD-BURN-RW           : No
Buffer Underrun Protection : Yes
Mount Rainier              : No
SolidBurn                  : No
Labelflash                 : No
Modes                      : Packet, TAO, DAO, SAO, RAW SAO, RAW SAO 16, 
RAW SAO 96, RAW DAO 96

Region Protection Control  : RPC II
Region                     : 2
Changes User               : 4
Changes Vendor             : 4


Drive Information
------------------
Drive                      : E-IDE    CD-ROM 56X/AKH
Type                       : CD-ROM Drive
Firmware Version           : A80
Buffer Size                : 192 KB
Date                       : ?
Serial Number
Vendor Specific            :
Drive Letter               : D:\
Location                   : 1:1
Mechanism                  : Tray
Read Speed                 :  n/a
Write Speed                :  n/a

Read CD Text               : No
Return C2 Pointers         : No
Read CD-R                  : Yes
Read CD-RW                 : Yes
Read DVD-ROM               : No
Read DVD-RAM               : No
Read DVD-R                 : No
Read DVD-RW                : No
Read DVD-R DL              : No
Read DVD+R                 : No
Read DVD+RW                : No
Read DVD+R DL              : No
Read BD-ROM                : No
Read BD-R                  : No
Read BD-RE                 : No
Read HD DVD-ROM            : No
Read HD DVD-R              : No
Read HD DVD-RW             : No
Read HD-BURN               : No
Read Digital Audio         : Yes
Read CD+G                  : No
Read VideoCD               : Yes

Write CD-R                 : No
Write CD-RW                : No
Write DVD-R                : No
Write DVD-RW               : No
Write DVD-R DL             : No
Write DVD+R                : No
Write DVD+RW               : No
Write DVD+R DL             : No
Write DVD-RAM              : No
Write BD-R                 : No
Write BD-RE                : No
Write HD DVD-R             : No
Write HD DVD-RW            : No
Write HD-BURN-R            : No
Write HD-BURN-RW           : No
Buffer Underrun Protection : No
Mount Rainier              : No
SolidBurn                  : No
Labelflash                 : No
Modes                      : n/a

Regards,

Yarema


> Could you please check whether the IDE driver work for it? (Please configure the
> IDE pdc202xx_new and deconfig the libata pata_pdc2027x driver, recompile/reboot
> the kernel and try read some cd using the IDE driver.) Thanks.
> 
> --
> albert
> 
> 
> 
> 


From: YUP <yupadmin@gmail.com>
Subject: Re: libata: CD and dvd devices not recognized
Date: Sat, 17 Mar 2007 10:09:35 +0100
Message-ID: <45FBB04F.7020102@gmail.com>
References: <45F873AC.6010204@gmail.com> <45F8C3E1.3080805@tw.ibm.com> <45F9460E.7020701@gmail.com> <45F98343.3060703@tw.ibm.com> <45FA6E8A.5070507@gmail.com> <45FAB270.8090909@tw.ibm.com> <45FB1C24.1000502@gmail.com> <45FB5F83.6070409@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:30619 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933764AbXCQJJj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Mar 2007 05:09:39 -0400
Received: by ug-out-1314.google.com with SMTP id 44so895613uga
        for <linux-ide@vger.kernel.org>; Sat, 17 Mar 2007 02:09:38 -0700 (PDT)
In-Reply-To: <45FB5F83.6070409@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: linux-ide@vger.kernel.org

Hi Albert,

I confirm that windows can read data from this drive. Autoplay works 
too. Even more, after I inserted dist into cdrom drive nero-info showed 
speed 52X:

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
Read Speed                 : 52 , 40 , 32 , 24 , 16 , 8 , 4  X
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

I tried to start linux box with inserted cd into drive but it didn't help.

Yarema


> Ok. Can windows or nero read any data out of the drive?
> If not, we can be quite sure it's broken hardware.
> --
> albert


> 
> 


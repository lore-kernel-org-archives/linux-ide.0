From: Tejun Heo <htejun@gmail.com>
Subject: Re: HSM violation on bootup, ICH7 + ata_piix 2.6.22
Date: Sat, 08 Sep 2007 16:52:55 +0900
Message-ID: <46E254D7.5020902@gmail.com>
References: <1188815959.24223.18.camel@ukabzc383.uk.saic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:40891 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754752AbXIHRHm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Sep 2007 13:07:42 -0400
Received: by wa-out-1112.google.com with SMTP id v27so940147wah
        for <linux-ide@vger.kernel.org>; Sat, 08 Sep 2007 10:07:42 -0700 (PDT)
In-Reply-To: <1188815959.24223.18.camel@ukabzc383.uk.saic.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Eamonn Hamilton <EAMONN.HAMILTON@saic.com>
Cc: linux-ide@vger.kernel.org

Eamonn Hamilton wrote:
> Hi,
> 
> I'm looking ta a Dell SC440 system for a friend, and it's giving HSM
> violations at startup.
> 
> The system itself has an ICH7 chipset, with two seagate ST3160812AS
> drives attached along with a single ST3400832AS, running kernel 2.6.22
> and the ata_piix driver.
> 
> I'm guessing this isn't good :(
> 
> Anybody gt any suggestions?
> 
> The violations are :
> 
> 
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata1.00: cmd b0/d2:f1:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data
> 123392 in
>          res 50/00:f1:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM
> violation)

Please disable or upgrade smartd.

-- 
tejun


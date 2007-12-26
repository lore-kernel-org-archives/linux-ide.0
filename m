From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: HSM violation errors
Date: Wed, 26 Dec 2007 00:57:35 -0600
Message-ID: <4771FB5F.6070608@shaw.ca>
References: <fa.h7PRfrlP7LlqB19GxhqX2RLeHc8@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:27221 "EHLO
	pd2mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238AbXLZG5i (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Dec 2007 01:57:38 -0500
In-reply-to: <fa.h7PRfrlP7LlqB19GxhqX2RLeHc8@ifi.uio.no>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Mitchell <jeffrey.mitchell@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Jeff Mitchell wrote:
> I'm seeing errors in dmesg and the like.  It appears to be somewhat
> similar to the issue reported here:
> http://kerneltrap.org/mailarchive/linux-kernel/2007/8/25/164711 except
> that my machine doesn't freeze, and everything seems normal --
> hopefully nothing like silent corruption is going on.  Also it's on
> brand new hardware...Intel ICH8 mobile chipset with AHCI.  Output from
> dmesg, hdparm -I /dev/sda and hdparm --drq-hsm-error /dev/sda is
> below...please let me know if there's anything else that would be of
> use (and, of course, if this is something I should be worried about
> :-)  ).
> 
> Thanks.
> Jeff
> 
> 
> dmesg:
> 
> ata1.00: exception Emask 0x2 SAct 0xfffd SErr 0x0 action 0x2 frozen
> ata1.00: spurious completions during NCQ issue=0x1 SAct=0xfffd
> FIS=005040a1:00000002

You didn't say what kernel you were using, but in the latest kernels 
this spurious completion check was removed since it was broken, so this 
error shouldn't happen anymore.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [RFC PATCH] nForce4 ADMA with NCQ: It's aliiiive..
Date: Sat, 07 Oct 2006 09:54:52 -0600
Message-ID: <4527CDCC.1080209@shaw.ca>
References: <45276085.3040102@shaw.ca> <200610071142.26045.prakash@punnoor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:45213 "EHLO
	pd3mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932280AbWJGPyz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 7 Oct 2006 11:54:55 -0400
In-reply-to: <200610071142.26045.prakash@punnoor.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Prakash Punnoor <prakash@punnoor.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, jeff@garzik.org

Prakash Punnoor wrote:
> Am Samstag 07 Oktober 2006 10:08 schrieb Robert Hancock:
>> I've been working on the patch for sata_nv ADMA support for nForce4 that
> 
> Nice!
> 
>> make the default 1). I only enabled ADMA on those chipsets and not
>> MCP51, MCP55 or MCP61 since that was all that the original NVIDIA
>> version did. I assume there was a reason for this, though maybe not.
> 
> Unfortunately it doesn't work for me on MCP51 if I change GENERIC to ADMA. So 
> I wonder whether MCP51 has ADMA mode or what needs to be done to get NCQ 
> working. :-(

What happened when you tried it? It would be useful if you could change 
the #undef in these lines:

  53 #undef ATA_DEBUG                /* debugging output */
  54 #undef ATA_VERBOSE_DEBUG        /* yet more debugging output */

in include/linux/libata.h to #define and rebuild and try it then, that 
will spew out a bunch more output and I can see if any reasonable 
looking values are showing up at all. I was capturing this output the 
crude way, booting with vga=6 to get a smaller font and taking a picture 
of the screen :-) Also, maybe post the lspci -v output from the SATA 
controller..

If that doesn't provide any insight, maybe the docs Jeff has provide the 
answer for whether or not the MCP5x/MCP61 controllers have the same 
interface as the CK804/MCP04..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

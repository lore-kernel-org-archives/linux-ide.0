From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH 2.6.32] MCP5x conditional MSI support for sata_nv
Date: Wed, 05 Aug 2009 17:45:51 -0600
Message-ID: <4A7A19AF.9040400@gmail.com>
References: <20090804233234.7251110075@gold.linx.net> <20090804193508.4bb868f3@fido2.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f213.google.com ([209.85.217.213]:43718 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267AbZHEXpy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Aug 2009 19:45:54 -0400
Received: by gxk9 with SMTP id 9so628602gxk.13
        for <linux-ide@vger.kernel.org>; Wed, 05 Aug 2009 16:45:54 -0700 (PDT)
In-Reply-To: <20090804193508.4bb868f3@fido2.homeip.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Philip Langdale <philipl@overt.org>
Cc: Tony Vroon <tony@linx.net>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On 08/04/2009 08:35 PM, Philip Langdale wrote:
> On Wed,  5 Aug 2009 00:32:34 +0100 (BST)
> Tony Vroon<tony@linx.net>  wrote:
>
>> The nVidia MCP55 controller quite happily supports MSI.
>> This adds an option to use it. It is disabled by default and
>> will only be honoured on MCP5x series controllers.
>> This was suggested in 2007 back when the driver was less mature,
>> perhaps now is a better time for it.
>
> I don't use an MCP55 motherboard anymore but I ran with MSI on for
> multiple years to no ill effect. However, in this thread where I
> reported my success, another person reported failure with MCP51.
>
> http://www.nvnews.net/vbulletin/showthread.php?t=101144&highlight=sata_nv+msi
>
> Assuming that's true, you can't use the 'MCP5x' test as that will
> cover MCP51 as well.

I'd take that with a bit of a grain of salt as there have been a lot of 
HT MSI fixups included since those posts (2007). Some motherboards 
didn't enable HT MSI mapping capabilities by default, which would 
prevent MSI from working.

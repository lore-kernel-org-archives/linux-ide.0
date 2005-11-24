From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] PATA support for Intel ICH7 (intel 945G chipset) - 2.6.14.2
Date: Thu, 24 Nov 2005 11:46:43 -0500
Message-ID: <4385EE73.1020709@pobox.com>
References: <4383DC5E.3050601@panoch.net> <438453C9.4050200@gentoo.org> <4385D79E.5060107@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932390AbVKXQqz@vger.kernel.org>
In-Reply-To: <4385D79E.5060107@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: Daniel Drake <dsd@gentoo.org>, Jan Panoch <jan@panoch.net>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Mark Lord wrote:
> Daniel Drake wrote:
> 
>>
>> Documentation/SubmittingPatches). I don't think it will be accepted 
>> because this hardware is already supported by the ata_piix libata driver.
> 
> 
> That is not a valid reason to reject -- libata is still considered
> very experimental for ATAPI devices, which are not enabled by default.
> 
> Jeff has said that he prefers (at present) for people with ATAPI drives
> to use the IDE layer rather than libata, where possible.

PATA ATAPI, not all ATAPI...

	Jeff

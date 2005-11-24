From: Mark Lord <lkml@rtr.ca>
Subject: Re: [PATCH] PATA support for Intel ICH7 (intel 945G chipset) - 2.6.14.2
Date: Thu, 24 Nov 2005 10:09:18 -0500
Message-ID: <4385D79E.5060107@rtr.ca>
References: <4383DC5E.3050601@panoch.net> <438453C9.4050200@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751365AbVKXPJb@vger.kernel.org>
In-Reply-To: <438453C9.4050200@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Drake <dsd@gentoo.org>
Cc: Jan Panoch <jan@panoch.net>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Daniel Drake wrote:
>
> Documentation/SubmittingPatches). I don't think it will be accepted 
> because this hardware is already supported by the ata_piix libata driver.

That is not a valid reason to reject -- libata is still considered
very experimental for ATAPI devices, which are not enabled by default.

Jeff has said that he prefers (at present) for people with ATAPI drives
to use the IDE layer rather than libata, where possible.

That will change soon, but it's still the case for now.

Cheers

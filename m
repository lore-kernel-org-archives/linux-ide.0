From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] sata_via VT6421 vendor update
Date: Sun, 11 Dec 2005 23:35:46 -0500
Message-ID: <439CFE22.7080502@rtr.ca>
References: <439CF781.3080400@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751095AbVLLEfs@vger.kernel.org>
In-Reply-To: <439CF781.3080400@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> 
> VIA contributed the attached update to sata_via, which adds support for 
> the third (PATA) port, and switches around the reset method a bit.

Too many inline busy-waits.. needs to use timers & callbacks instead.
But it might do in the interim, until that stuff gets fixed.

Cheers

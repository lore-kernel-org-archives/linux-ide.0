From: Tim Small <tim@seoss.co.uk>
Subject: Re: Marvell 88SE9320 SATA controller failure during heavy load
Date: Sun, 11 Jan 2015 17:39:28 +0000
Message-ID: <54B2B550.9050807@seoss.co.uk>
References: <CAPRPZsAZ1n0pd6kviJ5E8C6gV3RGECEZYGQx=485wysS_OYcxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay1.allsecuredomains.com ([78.47.234.210]:36443 "EHLO
	relay1.allsecuredomains.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750872AbbAKRja (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Jan 2015 12:39:30 -0500
In-Reply-To: <CAPRPZsAZ1n0pd6kviJ5E8C6gV3RGECEZYGQx=485wysS_OYcxA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>, linux-ide@vger.kernel.org

On 11/01/15 12:32, Jeroen Van den Keybus wrote:

> when a SMART command is issued during the transfers,
> occasionally the following error occurs:

[...]

> Thanks for any advice,

I've seen several models of WD drive  which fail when you issue SMART
commands during heavy I/O load, (all older vintages of drive than yours,
but I've largely avoided WD since then so couldn't say with much
certainty if they've fixed these issues in their drive firmware).

I've also seen multiple failures under load with multiple Marvell
controllers (all Marvell AHCI controllers) unless NCQ is disabled.  Best
guess is that this is due to a long standing controller design fault.

If I were seeing this problem, and I had a spare PCIe slot, then I'd
swap out the Marvell based controller for either 2x Silicon Image 3132
based cards, or alternatively 2x Asmedia 1061 (e.g. SY-PEX40039), to see
if the problems go away.

I'm using both controller chips in high load situations without problems
at the moment.

Tim.



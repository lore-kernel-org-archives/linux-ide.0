From: Tim Small <tim@seoss.co.uk>
Subject: Re: blkdiscard vs hdparm for erasing a SSD?
Date: Wed, 15 Oct 2014 15:21:18 +0100
Message-ID: <543E82DE.8070405@seoss.co.uk>
References: <2523736.cvg5kvG8qa@al>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay1.allsecuredomains.com ([78.47.234.210]:37497 "EHLO
	relay1.allsecuredomains.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751617AbaJOOxK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Oct 2014 10:53:10 -0400
In-Reply-To: <2523736.cvg5kvG8qa@al>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter Wu <peter@lekensteyn.nl>, linux-ide@vger.kernel.org, util-linux@vger.kernel.org

On 15/10/14 14:12, Peter Wu wrote:
> [ blkdiscard vs hdparm --security-erase] How does this compare. The goal is to erase the contents of an previously used SSD to improve performance.
>

When you use blkdiscard, the SSD (assuming a SATA SSD) will receive an
ATA TRIM command, whereas hdparm --security-erase will issue an ATA
SECURITY ERASE UNIT command.

What the drive then actually does is dependant on the implementation
details of that particular SSD's firmware.

In general, I would expect the performance gain from TRIMing the entire
drive to be either the same-as, or possibly less-than the gain from
SECURITY ERASE.  For a sane firmware implementation I'd expect them to
have the same effect on performance.  Firmware implementations are not
always sane.

Personally, unless I want to keep some of the data on the drive, I use
hdparm --security-erase, as I feel that this is most likely to reset the
drive to its as-new state (or at least close to it), but the real answer
is that it depends on the drive, so if you really want to know, you'll
have to do some performance tests on your drive(s).

Tim.

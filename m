From: "George Spelvin" <linux@horizon.com>
Subject: Re: What's the SB600 64-bit DMA problem?
Date: Sat, 20 Sep 2008 20:15:29 -0400
Message-ID: <20080921001529.23400.qmail@science.horizon.com>
References: <20080920151712.10515.qmail@science.horizon.com>
 <da824cf30809201528o27478ae2h5894e39932622d3b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from science.horizon.com ([192.35.100.1]:19953 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751536AbYIUAPd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 Sep 2008 20:15:33 -0400
In-Reply-To: <da824cf30809201528o27478ae2h5894e39932622d3b@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: grundler@google.com
Cc: linux@horizon.com, linux-ide@vger.kernel.org

"Grant Grundler" <grundler@google.com> wrote:
> On Sat, Sep 20, 2008 at 8:17 AM, George Spelvin <linux@horizon.com> wrote:
>> I just got a couple of MSI KA92 (AMD 790FX-based) motherboards with
>> 8 GiB of RAM each.  I noticed on boot that the SB600 AHCI implementation
>> had a 32-bit DMA limitation, and looking in the archives, it
>> appears that folks from AMD think it doesn't need to be there.
>
> URL?
> Just want to be sure I'm looking at the same thread.

"About forcing 32bit DMA patch for AMD690G(SB600)"
http://marc.info/?t=120107450600001

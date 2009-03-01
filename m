From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: libata timeouts when stressing a Samsung HDD
Date: Sun, 01 Mar 2009 13:31:31 -0600
Message-ID: <49AAE293.2050903@gmail.com>
References: <20090202164053.4ecca9dd@dhcp-100-2-144.bos.redhat.com>	<49922A2D.508@kernel.org>	<49924F48.4000009@rtr.ca> <20090211152908.383744cd@dhcp-100-2-144.bos.redhat.com> <49934B20.4060206@rtr.ca> <49934D24.1050204@garzik.org> <4993A57D.6010107@gmail.com> <499D7A4B.5010804@rtr.ca> <499DFA33.8090009@kernel.org> <499E1AD9.9020904@gmail.com> <499E22FA.7030409@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.217.174]:49536 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110AbZCATbg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Mar 2009 14:31:36 -0500
Received: by gxk22 with SMTP id 22so4119293gxk.13
        for <linux-ide@vger.kernel.org>; Sun, 01 Mar 2009 11:31:34 -0800 (PST)
In-Reply-To: <499E22FA.7030409@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, Chuck Ebbert <cebbert@redhat.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hello,
> 
> Robert Hancock wrote:
>>>> If I recall correctly, The reported shadow register contents are bogus
>>>> when a timeout occurs.  So we don't actually know what the drive
>>>> state was.
>>>>
>>>> Or do we, Tejun?
>>> Yeah, it's bogus.  Maybe we should just report zeros.
>> Didn't know that. Shouldn't we be able to do a qc_fill_rtf before error
>> handling in this case? That would make it easier to tell if we lost an
>> interrupt or if the drive is just taking too long..
> 
> I think Alan already did it in the patches which added improved
> timeout handling callback.  Hmmm... Can't find it.  I thought it was
> in #upstream.  Anyways, I'm slightly worried about reading status
> blindly after timeout mainly due to experiences I had early while
> developing libata EH.  Some controllers were simply scary and very
> eager to lock up the whole machine.  That said, it could be that I'm
> just overly paranoid.  After all, with shared IRQ, we don't have
> control over when altstatus is read at least.

For some of these timeout issues I think it would make things a bit 
easier to diagnose, certainly.. With some controllers there might be a 
little bit of risk (nForce4 seems to be one of those twitchy ones, 
whether in ADMA mode or not, at least for command errors, possibly not 
for timeouts), however certainly for ones like AHCI which just store the 
D2H register FIS in memory, there's really no reason not to read it out..

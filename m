From: David Dillow <dave@thedillows.org>
Subject: Re: New driver mtipx2xx submission
Date: Wed, 01 Jun 2011 21:21:11 -0400
Message-ID: <1306977671.6711.34.camel@obelisk.thedillows.org>
References: <22A973199D2C2F46933448F6E7990A300204F2BC@ntxboimbx31.micron.com>
	 <20110428230605.78c55c70@lxorguk.ukuu.org.uk>
	 <22A973199D2C2F46933448F6E7990A300204F728@ntxboimbx31.micron.com>
	 <20110502184206.25907c5e@lxorguk.ukuu.org.uk>
	 <22A973199D2C2F46933448F6E7990A300214B0D6@ntxboimbx31.micron.com>
	 <20110511202013.075b07cc@lxorguk.ukuu.org.uk> <4DD722DB.8030303@micron.com>
	 <x49lixuyhhs.fsf@segfault.boston.devel.redhat.com>
	 <22A973199D2C2F46933448F6E7990A300239EA77@ntxboimbx31.micron.com>
	 <x49ipsp9voy.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from amavis-outgoing1.knology.net ([24.214.64.230]:40352 "EHLO
	amavis-outgoing1.knology.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753328Ab1FBBkl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Jun 2011 21:40:41 -0400
In-Reply-To: <x49ipsp9voy.fsf@segfault.boston.devel.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: "Asai Thambi Samymuthu Pattrayasamy (asamymuthupa) [CONTRACTOR]" <asamymuthupa@micron.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On Wed, 2011-06-01 at 15:51 -0400, Jeff Moyer wrote:
> "Asai Thambi Samymuthu Pattrayasamy (asamymuthupa) [CONTRACTOR]"
> <asamymuthupa@micron.com> writes:
> > Collected the perf data for ahci driver. As the call graph is getting 
> > distorted in the email, attaching the perf data call graph report.
> 
> Thanks, Asai!  I don't think cfq is the ideal I/O scheduler to be
> testing.  Could you run again with deadline and/or noop and see how that
> changes your throughput and perf report?  Also, just for completeness,
> could you tell us which kernel you ran this against?

Did the cc list get trimmed, or was the message too big for vger? It
didn't seem to make it to the list...

If it was too big, could someone trim it down a bit and repost?
Inquiring minds want to play along at home...

Thanks!


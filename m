From: Mark Lord <kernel@teksavvy.com>
Subject: Re: New driver mtipx2xx submission
Date: Tue, 03 May 2011 11:02:31 -0400
Message-ID: <4DC01907.50009@teksavvy.com>
References: <22A973199D2C2F46933448F6E7990A300204F2BC@ntxboimbx31.micron.com>	<20110428230605.78c55c70@lxorguk.ukuu.org.uk> <x49oc3lndyu.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:35932 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751224Ab1ECPCd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 May 2011 11:02:33 -0400
In-Reply-To: <x49oc3lndyu.fsf@segfault.boston.devel.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Asai Thambi Samymuthu Pattrayasamy (asamymuthupa) [CONTRACTOR]" <asamymuthupa@micron.com>, linux-ide@vger.kernel.org

On 11-05-02 02:40 PM, Jeff Moyer wrote:
..
> Given the highly parallel nature of these parts, I wouldn't be surprised
> if the ahci queue depth of 31 is one of the main bottlenecks.  Can you
> think of a way to extend the ahci driver in this manner to accommodate
> devices like this one?
..

I imagine that another performance drain might be libata's lack of
support for host controller queues --> a hardware queuing layer that
exists between the host and the drive's own queuing mechanism.

Most modern ATA/SATA chipsets have something of that nature.
These are designed to eliminate the activity-gaps that happen between
when a drive finishes a command, and when the host interrupt -> BH -> whatever
gets around to submitting a new command.

With commands already batched up in a hardware host queue, the controller
takes care of that part, keeping the drive active more of the time,
increasing IOPS.

Cheers

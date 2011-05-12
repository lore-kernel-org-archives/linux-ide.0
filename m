From: Jeff Garzik <jeff@garzik.org>
Subject: Re: New driver mtipx2xx submission
Date: Thu, 12 May 2011 10:39:31 -0400
Message-ID: <4DCBF123.1050607@garzik.org>
References: <22A973199D2C2F46933448F6E7990A300204F2BC@ntxboimbx31.micron.com> <20110428230605.78c55c70@lxorguk.ukuu.org.uk> <x49oc3lndyu.fsf@segfault.boston.devel.redhat.com> <4DC01907.50009@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:43601 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757518Ab1ELOje (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 May 2011 10:39:34 -0400
Received: by ywj3 with SMTP id 3so535337ywj.19
        for <linux-ide@vger.kernel.org>; Thu, 12 May 2011 07:39:34 -0700 (PDT)
In-Reply-To: <4DC01907.50009@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: Jeff Moyer <jmoyer@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "Asai Thambi Samymuthu Pattrayasamy (asamymuthupa) [CONTRACTOR]" <asamymuthupa@micron.com>, linux-ide@vger.kernel.org

On 05/03/2011 11:02 AM, Mark Lord wrote:
> On 11-05-02 02:40 PM, Jeff Moyer wrote:
> ..
>> Given the highly parallel nature of these parts, I wouldn't be surprised
>> if the ahci queue depth of 31 is one of the main bottlenecks.  Can you
>> think of a way to extend the ahci driver in this manner to accommodate
>> devices like this one?
> ..
>
> I imagine that another performance drain might be libata's lack of
> support for host controller queues -->  a hardware queuing layer that
> exists between the host and the drive's own queuing mechanism.

What do you feel libata lacks, in this area?

AHCI has a host controller queue that it actively manages, and we ship 
off requests to that queue ASAP.

	Jeff




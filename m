From: Tim Small <tim@buttersideup.com>
Subject: Re: Hyper-V and IDE disks > 128GB
Date: Wed, 03 Nov 2010 11:15:03 +0000
Message-ID: <4CD14437.6070402@buttersideup.com>
References: <12CD8E2D-64F0-46D6-8ACB-C411D7BECEE7@jabberwocky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay1.allsecurenet.com ([63.246.152.102]:51136 "EHLO
	relay1.allsecurenet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754375Ab0KCLPH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Nov 2010 07:15:07 -0400
In-Reply-To: <12CD8E2D-64F0-46D6-8ACB-C411D7BECEE7@jabberwocky.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Shaw <dshaw@jabberwocky.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 02/11/10 18:52, David Shaw wrote:
> Can someone suggest a direction to go in next?
>   

I think I've seen this problem reported before, with the same diagnosis
that Alan gave.  i.e. it's a HyperV bug, albeit one which doesn't affect
Windows operating systems.

As I believe Microsoft and Redhat have some sort of co-support agreement
with respect to each other's virtualisation platforms, you may want to
report it on Redhat's bugzilla (after verifying that the fault is also
present in the RHEL6 beta).  I'd guess they'll either implement a
workaround or have some relatively straightforward mechanism to report
the fault to Microsoft - courtesy of their co-support agreement...

Cheers,

Tim.

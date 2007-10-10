From: Bruce Allen <ballen@gravity.phys.uwm.edu>
Subject: Re: smartd causing SATA timeouts on sleeping drives
Date: Wed, 10 Oct 2007 14:42:00 -0500 (CDT)
Message-ID: <Pine.LNX.4.63.0710101440380.4797@trinity.phys.uwm.edu>
References: <76366b180710051838h11c63c38o9a4248309ff9ee7d@mail.gmail.com>
 <4707ECF0.9030800@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from trinity.phys.uwm.edu ([129.89.57.159]:41138 "EHLO
	trinity.phys.uwm.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991AbXJJTmI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Oct 2007 15:42:08 -0400
In-Reply-To: <4707ECF0.9030800@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Andrew Paprocki <andrew@ishiboo.com>, linux-ide@vger.kernel.org

<SNIP>

> smartd should probably issue CHECK POWER MODE (0xe5) before issuing 
> other commands.  Bruce?

Hi Tejun,

Yes, this seems very reasonable.

I hope you say 'yes' to my offer from five minutes ago.

Cheers,
 	Bruce

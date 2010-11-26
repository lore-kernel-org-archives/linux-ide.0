From: Mark Lord <kernel@teksavvy.com>
Subject: Re: Bigger discard payloads
Date: Fri, 26 Nov 2010 08:52:51 -0500
Message-ID: <4CEFBBB3.4090508@teksavvy.com>
References: <yq1mxown6t7.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:20529 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755173Ab0KZNwx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Nov 2010 08:52:53 -0500
In-Reply-To: <yq1mxown6t7.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org, linux-fsdevel@vger.kernel.org

On 10-11-25 09:43 PM, Martin K. Petersen wrote:
>
> I posted the first version of this patch a few months ago. Inspired by
> the recent discussions I decided to take another stab at supporting TRIM
> payloads bigger than 512 bytes.

Most of the drives I have here advertise max payload of 512 bytes.

Given this, and that the kernel won't actually use more than one range today
(except for sequential/adjacent ranges), do we think that supporting
more than 512 bytes will be useful?

I suppose it could be useful once we get multiple non-adjacent range support.

Thanks!

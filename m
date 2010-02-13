From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ahci: disable FPDMA auto-activate optimization on NVIDIA
 AHCI
Date: Sat, 13 Feb 2010 17:46:58 -0500
Message-ID: <4B772BE2.30108@garzik.org>
References: <4B5FC213.1060601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.211.179]:57065 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757093Ab0BMWrB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Feb 2010 17:47:01 -0500
In-Reply-To: <4B5FC213.1060601@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Mike Cui <cuicui@gmail.com>, Peer Chen <pchen@nvidia.com>, Allen Martin <AMartin@nvidia.com>

On 01/26/2010 11:33 PM, Robert Hancock wrote:
> Mike Cui reported that his system with an NVIDIA MCP79 (aka MCP7A) chipset
> stopped working with 2.6.32. The problem appears to be that 2.6.32 now enables
> the FPDMA auto-activate optimization in the ahci driver. The drive works fine
> with this enabled on an Intel AHCI so this appears to be a chipset bug.
> Since MCP79 is a fairly recent NVIDIA chipset and we don't have any info on
> whether any other NVIDIA chipsets have this issue, disable FPDMA AA optimization
> on all NVIDIA AHCI controllers for now.
>
> Should address http://bugzilla.kernel.org/show_bug.cgi?id=14922
>
> Signed-off-by: Robert Hancock<hancockrwd@gmail.com>
>
> ---
>
> Mike, can you test this out and make sure this resolves the problem for you?

Sigh...   we never did hear back from Mike or NVIDIA on this one, did 
we?  I've been watching for a response, and haven't seen one to date.

	Jeff





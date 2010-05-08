From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] pata_cmd640: don't read CFR pointlessly
Date: Sat, 08 May 2010 17:44:51 -0400
Message-ID: <4BE5DB53.5040409@pobox.com>
References: <201005082227.19096.sshtylyov@ru.mvista.com> <4BE5D73C.30707@pobox.com> <4BE5D9E7.7080003@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:46427 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753425Ab0EHVox (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 May 2010 17:44:53 -0400
Received: by vws3 with SMTP id 3so623385vws.19
        for <linux-ide@vger.kernel.org>; Sat, 08 May 2010 14:44:53 -0700 (PDT)
In-Reply-To: <4BE5D9E7.7080003@mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

On 05/08/2010 05:38 PM, Sergei Shtylyov wrote:
> They were public once. And I think I've given you that spec along with
> other PCI-64x specs for publishing on gkernel.sourceforge.net/specs/
> already (can't open sii/cmd64x-specs.tar.bz2 now to check).

Based on this, I retract my comment.  Will apply patch as-is.

cmd64x-specs.tar was missing from my local doc archive, and I naively 
assumed everything in my public doc archive (gkernel.sf.net/specs/) was 
also stored locally.

	Jeff




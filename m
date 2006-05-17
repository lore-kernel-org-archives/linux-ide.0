From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH, RFC] ahci: update interrupt path
Date: Wed, 17 May 2006 10:25:17 +0900
Message-ID: <446A7B7D.1030606@gmail.com>
References: <20060517005752.GA14045@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.228]:41682 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751065AbWEQBZX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 May 2006 21:25:23 -0400
Received: by wr-out-0506.google.com with SMTP id i3so108036wra
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 18:25:22 -0700 (PDT)
In-Reply-To: <20060517005752.GA14045@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Patch against current #upstream.  Not yet committed.
> 
> Changes:
> * Drop PORT_IRQ_SG_DONE from IRQ mask.
> * Drop spurious interrupt code.
> * Add two events to hotplug event list; in theory, 
>   debounce should sort it all out.
> * Catch two other unhandled exceptions (overflow, bad PMP)

Can you hold on this for a bit please?  I'm not very sure about the 
spurious part yet.

-- 
tejun

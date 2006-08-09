From: Tejun Heo <htejun@gmail.com>
Subject: Re: cached PCS
Date: Wed, 09 Aug 2006 18:48:51 +0900
Message-ID: <44D9AF83.80507@gmail.com>
References: <44D97F07.9000301@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.230]:36473 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030616AbWHIJsz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 Aug 2006 05:48:55 -0400
Received: by wx-out-0506.google.com with SMTP id s14so112236wxc
        for <linux-ide@vger.kernel.org>; Wed, 09 Aug 2006 02:48:55 -0700 (PDT)
In-Reply-To: <44D97F07.9000301@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> can you resurrect your cached PCS patch?
> 
> 2.6.18-rc didn't fix the ghost device and long boot delay problems for 
> everybody.

The cached PCS patch was to fix device detection failure on some ICH5s 
where PCS is cleared while probing the first port.  Remaining ghost 
device and long boot delay are fixed by honor-PCS patch.  Do you want me 
to resurrect both?

-- 
tejun

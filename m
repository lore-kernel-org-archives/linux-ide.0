From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_vsc and device hotplug
Date: Fri, 30 Jun 2006 02:45:34 +0900
Message-ID: <44A411BE.9060308@gmail.com>
References: <20060629144956.GF16658@bork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.224]:2217 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751104AbWF2RpN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Jun 2006 13:45:13 -0400
Received: by wr-out-0506.google.com with SMTP id i21so122295wra
        for <linux-ide@vger.kernel.org>; Thu, 29 Jun 2006 10:45:12 -0700 (PDT)
In-Reply-To: <20060629144956.GF16658@bork.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Hicks <mort@bork.org>
Cc: linux-ide@vger.kernel.org

Martin Hicks wrote:
> So I've verified that device warmplug works correctly with the latest
> libata-dev#master tree.  What, conceptually, has to happen to the
> sata_vsc driver to get it to support hotplug.
> 
> Is it a case of getting the PHY state change interrupt to alert us when
> something comes alive on one of the ports?

Yeap, exactly.

-- 
tejun

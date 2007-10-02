From: Tejun Heo <htejun@gmail.com>
Subject: Re: ICH9 2 port SATA controller port map?
Date: Tue, 02 Oct 2007 16:57:28 +0900
Message-ID: <4701F9E8.6020403@gmail.com>
References: <39B20DF628532344BC7A2692CB6AEE0701CC0C09@orsmsx420.amr.corp.intel.com> <46FB0273.60302@gmail.com> <39B20DF628532344BC7A2692CB6AEE0701CF2D29@orsmsx420.amr.corp.intel.com> <46FDDFA5.8040209@gmail.com> <39B20DF628532344BC7A2692CB6AEE0701CF304E@orsmsx420.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.229]:40430 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457AbXJBInE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Oct 2007 04:43:04 -0400
Received: by wr-out-0506.google.com with SMTP id 36so2084375wra
        for <linux-ide@vger.kernel.org>; Tue, 02 Oct 2007 01:43:03 -0700 (PDT)
In-Reply-To: <39B20DF628532344BC7A2692CB6AEE0701CF304E@orsmsx420.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Gaston, Jason D" <jason.d.gaston@intel.com>
Cc: linux-ide@vger.kernel.org

Gaston, Jason D wrote:
>>> What is the difference between NA and RV?  If the controller only has
>>> access to 2 ports, does it matter which I set the nonexistent port
>>> values to in the map?
>> NA is used for unimplemented ports of a valid configuration while RV is
>> used to mark invalid MAP value.  So, NA should be mixed with P[0-3]
>> while RV can't be mixed with any other values.
>>
>> --
>> Tejun
> 
> When you say "can't be mixed" do you mean I should not have [P0 RV P1
> RV] on the same line?  If that is the case, then I assume my only
> choice, for the 2 port controller (physically ports 5 & 6) would be [P0
> NA P1 NA].

Yeap, that's correct.

-- 
tejun


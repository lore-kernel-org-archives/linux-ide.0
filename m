From: Tejun Heo <htejun@gmail.com>
Subject: Re: [patch] libata: use correct map_db values for ICH8
Date: Sat, 21 Oct 2006 01:35:20 +0900
Message-ID: <4538FAC8.4040709@gmail.com>
References: <20061019132739.10e504ef.kristen.c.accardi@intel.com>	<453891AD.70704@gmail.com> <20061020092622.f564da61.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:10055 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932274AbWJTQfa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Oct 2006 12:35:30 -0400
Received: by ug-out-1314.google.com with SMTP id z34so669864ugc
        for <linux-ide@vger.kernel.org>; Fri, 20 Oct 2006 09:35:28 -0700 (PDT)
In-Reply-To: <20061020092622.f564da61.kristen.c.accardi@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jeff@garzik.org

Kristen Carlson Accardi wrote:
>> Do you guys have doc update related to this?  The doc and spec update 
>> still indicate that MAP value is reserved to 00b.  Anyways, if you say 
>> that's right...
>>
>> Acked-by: Tejun Heo <htejun@gmail.com>
>>
> As far as I know, this has always been documented.
> The datasheet is located here:
> http://developer.intel.com/design/chipsets/datashts/313056.htm

Yeap, that's what I've been looking at for the whole time.

> Indicates that 10b is valid for combined mode.  Make sure you are looking
> at device 31 function 2 - for 31 function 5 it is hardwired to 00b, but
> for function 2, it can be 00 or 10.  This was not very clear, so it's
> easy to understand how this could have been misunderstood.  See 
> section 11.1.33 in the notes, or do a search on "combined mode" through
> the doc, and you'll see that MV can be 10b when SCC is 01 on device 31
> function 2.

Ah... you're right.  Thanks for pointing out.

-- 
tejun

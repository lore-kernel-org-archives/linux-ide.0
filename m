From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [RFC PATCH 1/3] libahci: save port map for forced port map
Date: Thu, 31 Mar 2016 17:51:42 +0100
Message-ID: <56FD559E.1090802@linaro.org>
References: <1459257075-21393-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1459257075-21393-2-git-send-email-srinivas.kandagatla@linaro.org>
 <20160330185706.GQ7822@mtj.duckdns.org> <56FD4923.3090209@linaro.org>
 <20160331164328.GA24661@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37811 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbcCaQvp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 31 Mar 2016 12:51:45 -0400
Received: by mail-wm0-f48.google.com with SMTP id p65so122385207wmp.0
        for <linux-ide@vger.kernel.org>; Thu, 31 Mar 2016 09:51:44 -0700 (PDT)
In-Reply-To: <20160331164328.GA24661@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>, Hans de Goede <hdegoede@redhat.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jmaggard10@gmail.com



On 31/03/16 17:43, Tejun Heo wrote:
> Hello,
>
> On Thu, Mar 31, 2016 at 04:58:27PM +0100, Srinivas Kandagatla wrote:
>> Yes, that is the intention, I guess, This was done exactly in case where the
>> port number was fabricated too.
>>
>> Without this I could not get the sata working on my board with forced port
>> map option.
>
> I see.  Looks good to me then.  Can you please respin the patches with
> the updates for the review points in the second patch?  I'll apply
> them to libata/for-3.6-fixes.

Thanks, I will do it now.

--srini
>
> Thanks.
>

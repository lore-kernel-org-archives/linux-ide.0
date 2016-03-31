From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [RFC PATCH 1/3] libahci: save port map for forced port map
Date: Thu, 31 Mar 2016 16:58:27 +0100
Message-ID: <56FD4923.3090209@linaro.org>
References: <1459257075-21393-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1459257075-21393-2-git-send-email-srinivas.kandagatla@linaro.org>
 <20160330185706.GQ7822@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37155 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757047AbcCaP6b (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 31 Mar 2016 11:58:31 -0400
Received: by mail-wm0-f52.google.com with SMTP id p65so120514949wmp.0
        for <linux-ide@vger.kernel.org>; Thu, 31 Mar 2016 08:58:30 -0700 (PDT)
In-Reply-To: <20160330185706.GQ7822@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>, Hans de Goede <hdegoede@redhat.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jmaggard10@gmail.com



On 30/03/16 19:57, Tejun Heo wrote:
> Hello,
>
> On Tue, Mar 29, 2016 at 02:11:13PM +0100, Srinivas Kandagatla wrote:
>> In usecases where force_port_map is used saved_port_map is never set,
>> resulting in not programming the PORTS_IMPL register as part of intial
>> config. This patch fixes this by setting it to port_map even in case
>> where force_port_map is used, making it more inline with other parts of
>> the code.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/ata/libahci.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
>> index 3982054..a5d7c1c 100644
>> --- a/drivers/ata/libahci.c
>> +++ b/drivers/ata/libahci.c
>> @@ -507,6 +507,7 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
>>   		dev_info(dev, "forcing port_map 0x%x -> 0x%x\n",
>>   			 port_map, hpriv->force_port_map);
>>   		port_map = hpriv->force_port_map;
>> +		hpriv->saved_port_map = port_map;
>
> So, the only change it'd cause is making the driver write the forced
> value to the PI register.  Does that make sense?

Yes, that is the intention, I guess, This was done exactly in case where 
the port number was fabricated too.

Without this I could not get the sata working on my board with forced 
port map option.

--srini


>
> Thanks.
>

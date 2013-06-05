From: Mark Langsdorf <mark.langsdorf-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/2 v2] sata highbank: add bit-banged SGPIO driver support
Date: Wed, 05 Jun 2013 15:19:30 -0500
Message-ID: <51AF9D52.2030609@calxeda.com>
References: <1369945051-2582-2-git-send-email-mark.langsdorf@calxeda.com>
 <1370266538-14211-1-git-send-email-mark.langsdorf@calxeda.com>
 <20130603203727.GB29989@mtj.dyndns.org> <51AE0335.902@calxeda.com>
 <20130604203251.GF14916@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130604203251.GF14916-Gd/HAXX7CRxy/B6EtB590w@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

On 06/04/2013 03:32 PM, Tejun Heo wrote:
> Hello, Mark.
> 
> On Tue, Jun 04, 2013 at 10:09:41AM -0500, Mark Langsdorf wrote:
>>> And tell ahci core sizeof(ecx_host_priv) some way, but really, just
>>> having a plain pointer should be enough, I think.
>>
>> I think I want to do the opposite. For 90% of the AHCI EM functions,
>> I want ecx_host_priv to be an ahci_host_priv so that I can use those
>> functions without having to keep a local copy of them.
>>
>> Would something like this:
>> struct ahci_host_priv {
>> 	/* standard AHCI existing stuff */
>> 	void *private_data;
>> };
>>
>> I shied away from that because a private data structure having a private
>> data structure doesn't seem right.
> 
> Aren't we talking about the same thing?  I'm perfectly fine with
> adding a pointer to ahci_host_priv.  Maybe you can name it slightly
> differently - say, *impl_data, *platform_data, whatever.

I guess we are talking about the same thing. I'll do that.

>>>> +static ssize_t ecx_transmit_led_message(struct ata_port *ap, u32 state,
>>>> +					ssize_t size)
>>>> +{
>>> ...
>>>> +	if (!hpriv->em_msg_type & EM_MSG_TYPE_LED)
>>>> +		return size;
>>>
>>> Is this really correct?  You first negate and convert it to bool and
>>> then bit-wise and it with a mask?  How is supposed to work?
>>
>> Am I confused about the order of operations? It's meant to be "continue
>> if hpriv->em_msg_type doesn't have EM_MSG_TYPE_LED set".
> 
> Shouldn't that be
> 
> 	if (!(hpriv->em_msg_type & EM_MSG_TYPE_LED))
> 
> ! has higher priority than &.  You're converting em_msg_type to 1 or 0
>   and then and'ing EM_MSG_TYPE_LED to it.

I'll fix it then.

--Mark Langsdorf
Calxeda, Inc.

From: Mark Langsdorf <mark.langsdorf-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/2] sata highbank: add bit-banged SGPIO driver support
Date: Thu, 06 Jun 2013 07:14:08 -0500
Message-ID: <51B07D10.2060609@calxeda.com>
References: <1369945051-2582-2-git-send-email-mark.langsdorf@calxeda.com>
 <1370471508-30806-1-git-send-email-mark.langsdorf@calxeda.com>
 <20130605231517.GP10693@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130605231517.GP10693-9pTldWuhBndy/B6EtB590w@public.gmane.org>
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

,On 06/05/2013 06:15 PM, Tejun Heo wrote:
> Hello,
> 
> On Wed, Jun 05, 2013 at 05:31:48PM -0500, Mark Langsdorf wrote:
>> +static void ecx_parse_sgpio(struct ecx_plat_data *pdata, u32 port, u32 state)
>> +{
>> +	if (state & ECX_ACTIVITY_BITS)
>> +		pdata->sgpio_pattern |= sgpio_bit_shift(pdata, port,
>> +						ECX_ACTIVITY_SHIFT);
>> +	else
>> +		pdata->sgpio_pattern &= sgpio_bit_shift(pdata, port,
>> +						ECX_ACTIVITY_SHIFT);
> 
> Shouldn't it be "&= ~" instead of "&="?  You're trying to turn the bit
> off, right?

Oops. Thanks!

--Mark Langsdorf
Calxeda, Inc.

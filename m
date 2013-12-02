From: Valentine <valentine.barshak@cogentembedded.com>
Subject: Re: [PATCH V3 1/2] sata_rcar: Add R-Car Gen2 SATA PHY support
Date: Mon, 02 Dec 2013 14:07:24 +0400
Message-ID: <529C5BDC.7080006@cogentembedded.com>
References: <1383912570-8393-1-git-send-email-valentine.barshak@cogentembedded.com> <1383912570-8393-2-git-send-email-valentine.barshak@cogentembedded.com> <52951B4D.3030205@cogentembedded.com> <20131129201406.GD21755@mtj.dyndns.org> <5298FAA8.2050300@cogentembedded.com> <20131129204231.GE21755@mtj.dyndns.org> <20131202000201.GA14523@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20131202000201.GA14523@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Tejun Heo <tj@kernel.org>
Cc: linux-sh@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Kumar Gala <galak@codeaurora.org>, Vladimir Barinov <vladimir.barinov@cogentembedded.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-ide@vger.kernel.org

On 12/02/2013 04:02 AM, Simon Horman wrote:
> On Fri, Nov 29, 2013 at 03:42:31PM -0500, Tejun Heo wrote:
>> On Sat, Nov 30, 2013 at 12:35:52AM +0400, Valentine wrote:
>>> On 11/30/2013 12:14 AM, Tejun Heo wrote:
>>>> Hello,
>>>>
>>>> On Wed, Nov 27, 2013 at 02:06:05AM +0400, Valentine wrote:
>>>>> On 11/08/2013 04:09 PM, Valentine Barshak wrote:
>>>>>
>>>>> Tejun,
>>>>> are you OK with taking this?
>>>>
>>>> Yeah, the stat part looks okay to me.  How the two should be routed?
>>>> Both through libata or should I just take the first one?
>>>
>>> I'm not sure about that. I'm more concerned about the first one.
>>> But I wouldn't mind if you take both.
>>
>> Applied the first one to libata/for-3.14.  Are people happy with the
>> second one?  If so, I'll put route that through libata/for-3.14 too.
>
> Hi,
>
> Assuming that the second one is " [PATCH V3 2/2] dt: Document sata_rcar
> bindings" then from my point of view it would be ideal if you took it.
> However, it seems that there is still some discussion on the contents
> between Valentine and Kumar Gala.
>

Thanks, Simon.
Actually between Laurent and Kumar.
Since the R-Car Gen2 DTS file have been updated to include the IRQ macros,
I don't see any issues with applying the binding documentation from this
series.

Thanks,
Val.

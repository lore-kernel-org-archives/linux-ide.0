From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: RE: [PATCH v2 2/3] ep93xx: IDE driver platform support code
Date: Wed, 4 Apr 2012 12:11:44 -0500
Message-ID: <ADE657CA350FB648AAC2C43247A983F002069840A0CF@AUSP01VMBX24.collaborationhost.net>
References: <4F7B0C54.8010804@metasoft.pl> <4F7B0D6C.1010801@metasoft.pl>
 <ADE657CA350FB648AAC2C43247A983F0020698409DF4@AUSP01VMBX24.collaborationhost.net>
 <4F7C0922.1070200@metasoft.pl>
 <ADE657CA350FB648AAC2C43247A983F002069840A08A@AUSP01VMBX24.collaborationhost.net>
 <ADE657CA350FB648AAC2C43247A983F002069840A0A8@AUSP01VMBX24.collaborationhost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail132.messagelabs.com ([216.82.242.115]:10773 "EHLO
	mail132.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757048Ab2DDRLu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Apr 2012 13:11:50 -0400
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F002069840A0A8@AUSP01VMBX24.collaborationhost.net>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rafal Prylowski <prylowski@metasoft.pl>
Cc: "rmallon@gmail.com" <rmallon@gmail.com>, Sergei Shtylyov <sshtylyov@mvista.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "joao.ramos@inov.pt" <joao.ramos@inov.pt>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "bzolnier@gmail.com" <bzolnier@gmail.com>

On Wednesday, April 04, 2012 9:43 AM, H Hartley Sweeten wrote:
> On Wednesday, April 04, 2012 9:20 AM, H Hartley Sweeten wrote:
>> On Wednesday, April 04, 2012 1:41 AM, Rafal Prylowski wrote:
>>> On 2012-04-03 19:41, H Hartley Sweeten wrote:
>>> [not related to my patch, but ep93xx keypad]:
>>> Isn't ep93xx_keypad_acquire_gpio be more correct if we apply the following patch:
>>>
>>> Index: linux-2.6/arch/arm/mach-ep93xx/core.c
>>> ===================================================================
>>> --- linux-2.6.orig/arch/arm/mach-ep93xx/core.c
>>> +++ linux-2.6/arch/arm/mach-ep93xx/core.c
>>> @@ -734,7 +734,7 @@ int ep93xx_keypad_acquire_gpio(struct pl
>>>  fail_gpio_d:
>>>  	gpio_free(EP93XX_GPIO_LINE_C(i));
>>>  fail_gpio_c:
>>> -	for ( ; i >= 0; --i) {
>>> +	for (--i; i >= 0; --i) {
>>>  		gpio_free(EP93XX_GPIO_LINE_C(i));
>>>  		gpio_free(EP93XX_GPIO_LINE_D(i));
>>>  	}
>>>
>>> This way we don't double free EP93XX_GPIO_LINE_C(i), and don't free lines which were not
>>> successfully acquired (I noticed this when writing my patch, which is based on
>>> ep93xx_keypad_acquire/release_gpio).
>>
>> You are correct... ;-)
>>
>> Care to submit an actual patch?
>
> Note, if/when the devm_gpio_request patch gets into the kernel tree we can use
> that and get rid of the gpio_free's completely.
>
> Sorry, I don't have a link to that patch...

I just pulled linux-next. It looks like the devm_gpio_* stuff is now in.

commit 1a0703ede4493bd74f9c6b53f782b749e175a88e
Author: John Crispin <blogic@openwrt.org>
Date:   Tue Dec 20 21:40:21 2011 +0100

    GPIO: add bindings for managed devices
    
    This patch adds 2 functions that allow managed devices to request GPIOs.
    These GPIOs will then be managed by drivers/base/devres.c.
    
    Signed-off-by: John Crispin <blogic@openwrt.org>
    Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Regards,
Hartley


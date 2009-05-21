From: Karl Hiramoto <karl@hiramoto.org>
Subject: Re: PCI IRQ Pins
Date: Thu, 21 May 2009 21:12:21 +0200
Message-ID: <4A15A795.4090100@hiramoto.org>
References: <4A13EC76.3020206@hiramoto.org>	<m3r5ykgd97.fsf@intrepid.localdomain>	<20090520205151.GC4095@n2100.arm.linux.org.uk>	<m3zld7cuxk.fsf@intrepid.localdomain>
	<4A14F160.6080605@hiramoto.org>	<4A150B9A.7080700@hiramoto.org>
	<4A1568FB.20508@ru.mvista.com>	<4A156A21.2060108@hiramoto.org>
	<4A156E36.6080806@hiramoto.org>
	<m3r5yi9zkr.fsf@intrepid.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ath9k-devel-bounces@lists.ath9k.org>
In-Reply-To: <m3r5yi9zkr.fsf@intrepid.localdomain>
List-Unsubscribe: <https://lists.ath9k.org/mailman/listinfo/ath9k-devel>,
	<mailto:ath9k-devel-request@lists.ath9k.org?subject=unsubscribe>
List-Archive: <http://lists.ath9k.org/pipermail/ath9k-devel>
List-Post: <mailto:ath9k-devel@lists.ath9k.org>
List-Help: <mailto:ath9k-devel-request@lists.ath9k.org?subject=help>
List-Subscribe: <https://lists.ath9k.org/mailman/listinfo/ath9k-devel>,
	<mailto:ath9k-devel-request@lists.ath9k.org?subject=subscribe>
Sender: ath9k-devel-bounces@lists.ath9k.org
Errors-To: ath9k-devel-bounces@lists.ath9k.org
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, "ath9k-devel@lists.ath9k.org" <ath9k-devel@lists.ath9k.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: linux-ide@vger.kernel.org

Krzysztof Halasa wrote:
> Karl Hiramoto <karl@hiramoto.org> writes:
>
>   
>> Sorry, think i misspoke,  after reading the IXP4xx dev manual it says 
>> 66Mhz PCI version 2.2.
>>     
>
> Typically the PCI clock on IXP4xx is 33 MHz but your board can use any
> value from 0 to 66.666 MHz. Most wifi cards don't work with 66 MHz,
> though. The only card working @ 66 MHz for me is CM9 (all cards I have
> fail to connect the M66EN line to ground, so they simply don't work
> instead of forcing 33 MHz clock). They are all based on ath5 chips.
>   
checking IXP4XX_EXP_CFG0  bit 4 is 0  so PCI_CLK  should be 33mhz

So i shouldn't have to tie the M66EN to ground.

--
Karl

From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 3/4] [POWERPC] MPC8349E-mITX: introduce localbus and
	pata nodes
Date: Tue, 04 Dec 2007 13:23:46 -0600
Message-ID: <4755A942.2010802@freescale.com>
References: <20071204170442.GA10460@localhost.localdomain>	<20071204170726.GC15599@localhost.localdomain>
	<20071204191657.GB5758@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <20071204191657.GB5758@lixom.net>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Jeff Garzik <jeff@garzik.org>, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-ide@vger.kernel.org

Olof Johansson wrote:
> Hi,
> 
> On Tue, Dec 04, 2007 at 08:07:26PM +0300, Anton Vorontsov wrote:
>> diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
>> index 5072f6d..c459b0a 100644
>> --- a/arch/powerpc/boot/dts/mpc8349emitx.dts
>> +++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
>> @@ -249,6 +249,22 @@
>>  		device_type = "pci";
>>  	};
>>  
>> +	localbus@e0005000 {
>> +		#address-cells = <2>;
>> +		#size-cells = <1>;
>> +		compatible = "fsl,mpc8349emitx-localbus",
>> +			     "fsl,mpc8349e-localbus",
>> +			     "fsl,pq2pro-localbus";
>> +		reg = <e0005000 d8>;
>> +		ranges = <3 0 f0000000 210>;
>>  
>> -
>> +		pata@3,0 {
> 
> What's the ,0 for?

chipselect 3, offset 0.

-Scott

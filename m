From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 1/9] devicetree: bindings: Add sata port phy config
 parameters in ahci-ceva
Date: Fri, 11 Aug 2017 14:36:37 +0200
Message-ID: <b9f44a24-f78b-fd42-f89b-13c04dca04ed@xilinx.com>
References: <cover.1501852693.git.michal.simek@xilinx.com>
 <b7692739885fe200a4ea5a4e3828349a406e2247.1501852693.git.michal.simek@xilinx.com>
 <20170810190720.yqeu4qzztylu5slb@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170810190720.yqeu4qzztylu5slb@rob-hp-laptop>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Michal Simek <michal.simek@xilinx.com>, Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, Alexander Graf <agraf@suse.de>, Tejun Heo <tj@kernel.org>, devicetree@vger.kernel.org, linux-ide@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-ide@vger.kernel.org

On 10.8.2017 21:07, Rob Herring wrote:
> On Fri, Aug 04, 2017 at 03:18:10PM +0200, Michal Simek wrote:
>> From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
>>
>> This patch adds device tree bindings for sata port phy parameters
>> in the ahci-ceva.txt file.
>>
>> Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>>  .../devicetree/bindings/ata/ahci-ceva.txt          | 39 ++++++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/ata/ahci-ceva.txt b/Documentation/devicetree/bindings/ata/ahci-ceva.txt
>> index 7ca8b976c13a..f97546f61444 100644
>> --- a/Documentation/devicetree/bindings/ata/ahci-ceva.txt
>> +++ b/Documentation/devicetree/bindings/ata/ahci-ceva.txt
>> @@ -5,6 +5,36 @@ Required properties:
>>    - compatible: Compatibility string. Must be 'ceva,ahci-1v84'.
>>    - clocks: Input clock specifier. Refer to common clock bindings.
>>    - interrupts: Interrupt specifier. Refer to interrupt binding.
>> +  - ceva,p0-cominit-params: OOB timing value for COMINIT parameter for port 0.
>> +  - ceva,p1-cominit-params: OOB timing value for COMINIT parameter for port 1.
>> +			The fields for the above parameter must be as shown below:
>> +			ceva,phy-cominit-params = /bits/ 8 <CIBGMN CIBGMX CIBGN CINMP>;
> 
> phy? Should be pN?

pN will be in v2.

Thanks,
Michal

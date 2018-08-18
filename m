From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCHv2] ide: Use NULL to compare with pointer-typed value
 rather than 0
Date: Sat, 18 Aug 2018 19:25:47 +0300
Message-ID: <1e17b3d3-4e5a-7318-e6f6-c8da311e26c8@cogentembedded.com>
References: <1534572961-16423-1-git-send-email-zhongjiang@huawei.com>
 <8badfdf8-ce69-1722-a489-fee161a1f4aa@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8badfdf8-ce69-1722-a489-fee161a1f4aa@cogentembedded.com>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
To: zhong jiang <zhongjiang@huawei.com>, davem@davemloft.net
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 08/18/2018 06:53 PM, Sergei Shtylyov wrote:

>> We should use NULL to compare with pointer-typed value rather than
>> 0. The issue is detected with the help of Coccinelle.
> 
>    Your description stopped to match the patch in v2.

  And your subject as well...

>    Actually, this X ==  NULL to !x preference is largely spocific to netdev...

   Specific, of course. :-)

> Although, IDE maintainer is the same now person. :-)  

  "The same person now" I wanted to type. :-)

>  
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
[...]

MBR, Sergei

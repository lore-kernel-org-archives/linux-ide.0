From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] 2.6.35 libata support for > 512 byte sectors (e.g. 4K
 Native)
Date: Tue, 17 Aug 2010 17:22:11 +0200
Message-ID: <4C6AA923.4040302@kernel.org>
References: <AANLkTikSSmP5f1csa=xPTR=EqY4D5a=6t2oDVkZ7cA-v@mail.gmail.com>	<CAC4B8726E86A142B27A9E9A2F2F12470149041A4E@rrsmsx505.amr.corp.intel.com>	<AANLkTik4RNvaE5OrFq3NmZ+-9DKhAAaNQ3cdPg38zOr2@mail.gmail.com>	<4C699455.6020200@pobox.com> <AANLkTi=R4GQGVE5AvU9hdWXdtqZzaOswrGQA+cPgO58W@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTi=R4GQGVE5AvU9hdWXdtqZzaOswrGQA+cPgO58W@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "Wilcox, Matthew R" <matthew.r.wilcox@intel.com>, Linux IDE <linux-ide@vger.kernel.org>, Gwendal Grignou <gwendal@google.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Hello,

On 08/16/2010 10:24 PM, Grant Grundler wrote:
> I suspect legacy tools might be needed to update firmware and those
> might continue to function if DRQ block size is still 512 byte.  I'd
> like to leave this hardcoded to ATA_SECT_SIZE until someone can
> demonstrate a need to change it. Ok?

I agree it'll be best to leave it 512bytes.  We'll just cause more
confusion by overriding the sector size there.  Another possible
approach would be simply failing the ioctl if logical sector size
isn't 512 byte.  The ioctl should probably be deprecated one day
anyway.

Thanks.

-- 
tejun

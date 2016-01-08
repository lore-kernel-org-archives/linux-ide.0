From: Daniel Walker <danielwa@cisco.com>
Subject: Re: [PATCH 1/2] drivers: pata_octeon_cf : Switch IO mode depending on
 model number
Date: Fri, 8 Jan 2016 12:37:39 -0800
Message-ID: <56901E13.3080301@cisco.com>
References: <1452230332-14926-1-git-send-email-danielwa@cisco.com>
 <20160108153049.GN1898@mtj.duckdns.org> <56901803.209@cisco.com>
 <CAOS58YP=bsJf3wAp4K_TqtwhvbbW+SvL0OpaeaP3zJiFsLK5KA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOS58YP=bsJf3wAp4K_TqtwhvbbW+SvL0OpaeaP3zJiFsLK5KA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Anil Veliyankara Madam <aveliyan@cisco.com>, xe-kernel@external.cisco.com, Shikha Jain <shikjain@cisco.com>, linux-ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, "Chris Hall (hall)" <hall@cisco.com>
List-Id: linux-ide@vger.kernel.org

On 01/08/2016 12:22 PM, Tejun Heo wrote:
> Hello,
>
> On Fri, Jan 8, 2016 at 3:11 PM, Daniel Walker <danielwa@cisco.com> wrote:
>> It's not specific to pata_octeon_cf , it should be applied to the device
>> regardless of controller. Is there a better place to put this to cover all ?
> Yeap, libata-core.c:ata_device_blacklist[]
>
> Thanks.
>

Will do (and resend). Thanks for the review.

Daniel

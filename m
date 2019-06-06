From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: libata: sysctl knob for enabling tpm/opal at runtime
Date: Thu, 6 Jun 2019 16:20:46 +0200
Message-ID: <3720d2a4-c8e8-0024-bc39-2aed5c4bf0a3@metux.net>
References: <1559734587-32596-1-git-send-email-info@metux.net>
 <20190605192320.GA16831@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190605192320.GA16831@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: linux-kernel@vger.kernel.org, axboe@kernel.dk, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 05.06.19 21:23, Christoph Hellwig wrote:
> On Wed, Jun 05, 2019 at 01:36:25PM +0200, Enrico Weigelt, metux IT consult wrote:
>> Hello folks,
>>
>>
>> here's a patchset that allows enabling libata's tpm features (opal)
>> at runtime. Until now we need to boot with special kernel parameter,
>> in order to use OPAL - this patch also adds a sysctl knob for that.
> 
> Or you can use the block/sed-opal.c code which doesn't require the
> tweak, and really is the proper way forward to use OPAL.

You're referring to the OPAL ioctl()s ?

hmm, it seems that sed-util doesn't use them at all, but directly
sends raw ata commands.

Shall I use a different userland tool ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287

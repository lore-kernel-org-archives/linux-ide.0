From: Christoph Hellwig <hch@infradead.org>
Subject: Re: libata: sysctl knob for enabling tpm/opal at runtime
Date: Wed, 5 Jun 2019 12:23:20 -0700
Message-ID: <20190605192320.GA16831@infradead.org>
References: <1559734587-32596-1-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1559734587-32596-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: linux-kernel@vger.kernel.org, axboe@kernel.dk, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wed, Jun 05, 2019 at 01:36:25PM +0200, Enrico Weigelt, metux IT consult wrote:
> Hello folks,
> 
> 
> here's a patchset that allows enabling libata's tpm features (opal)
> at runtime. Until now we need to boot with special kernel parameter,
> in order to use OPAL - this patch also adds a sysctl knob for that.

Or you can use the block/sed-opal.c code which doesn't require the
tweak, and really is the proper way forward to use OPAL.

> The first patch just introduces a systcl subdir for libata, the
> second one adds the actual knob. I had already sent these patches,
> few weeks ago, along with some general build fixes. The latter
> meanwhile went mainline, but haven't received any comments on
> the two opal related ones yet.

Independent of that new sysctls are deprecated.

From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] libata: force disable trim for SuperSSpeed S238
Date: Wed, 15 Jul 2015 07:26:20 -0700
Message-ID: <20150715142620.GB2127@kroah.com>
References: <1436961277-4069-1-git-send-email-arne_f@ipfire.org>
 <1436961277-4069-3-git-send-email-arne_f@ipfire.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1436961277-4069-3-git-send-email-arne_f@ipfire.org>
Sender: stable-owner@vger.kernel.org
To: Arne Fitzenreiter <arne_f@ipfire.org>
Cc: tj@kernel.org, linux-ide@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wed, Jul 15, 2015 at 01:54:37PM +0200, Arne Fitzenreiter wrote:
> This device loses blocks, often the partition table area, on trim.
> Disable TRIM.
> http://pcengines.ch/msata16a.htm
> 
> Signed-off-by: Arne Fitzenreiter <arne_f@ipfire.org>
> ---
>  drivers/ata/libata-core.c | 3 +++
>  1 file changed, 3 insertions(+)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>

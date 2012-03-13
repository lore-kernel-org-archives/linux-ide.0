From: Jeff Garzik <jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] drivers/ata/pata_mpc52xx.c: clean up error handling
 code
Date: Tue, 13 Mar 2012 16:45:14 -0400
Message-ID: <4F5FB1DA.6070009@pobox.com>
References: <1331496729-12850-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1331496729-12850-1-git-send-email-Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wharms-fPG8STNUNVg@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On 03/11/2012 04:12 PM, Julia Lawall wrote:
> From: Julia Lawall<Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
>
> This patch makes a number of changes with respect to the error-handling
> code:
>
> * Remove cleanup calls for the devm functions in both the error handling
>    code and the remove function.  This cleanup is done automatically.
>
> * The previous change simplifies the cleanup code at the end of the
>    function such that there is nothing to do on the failure of the call to
>    devm_ioremap.  So it is changed to just return directly.
>
> * There is no need for the ifs in the cleanup code at the end of the
>    function, because in each case the cleanup needed is statically
>    known.  Drop the ifs, add new err labels, and drop the initializations of
>    the tested variables to NULL.
>
> * Change the call to request_irq to a call to devm_request_irq, so that it
>    is cleaned up on exit.
>
> * Cause the return value of devm_request_irq to go into the returned
>    variable rv rather than the unused variable ret.  Drop ret.
>
> Signed-off-by: Julia Lawall<Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
>
> ---
> This subsumes the previous patch that only removed the calls to the devm
> cleanup functions.  It is not tested.  I am not sure about the correctness
> of the use of devm_request_irq, since there were no calls to free_irq
> before.  I also don't know if there was a reason for not returning the
> return value of request_irq previously.
>
>   drivers/ata/pata_mpc52xx.c |   44 +++++++++++++++-----------------------------
>   1 file changed, 15 insertions(+), 29 deletions(-)

applied

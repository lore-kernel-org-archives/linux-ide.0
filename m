From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH resend 2/2] libata-scsi: correct SPC version descriptor
Date: Tue, 12 Jul 2016 10:55:20 -0400
Message-ID: <20160712145520.GG3190@htj.duckdns.org>
References: <20160712132935.1811-1-me>
 <5784f0c7.8469620a.ab9e4.ffff999d@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-scsi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5784f0c7.8469620a.ab9e4.ffff999d@mx.google.com>
Sender: linux-scsi-owner@vger.kernel.org
To: tom.ty89@gmail.com
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, Jul 12, 2016 at 09:29:35PM +0800, tom.ty89@gmail.com wrote:
> From: Tom Yan <tom.ty89@gmail.com>
> 
> The comment suggests we should be having an SPC-3 version descriptor
> but the 0260h is the code for "SPC-2 (no version claimed)". Correct
> it to 0300h so that it has the "SPC-3 (no version claimed)" descriptor.
> 
> Note that we are claiming SPC-3 version compatibility in the VERSION
> field of the standard INQUIRY data. Therefore, I assume the typo was
> on the code but not on the comment.
> 
> Signed-off-by: Tom Yan <tom.ty89@gmail.com>

Applied 1-2 to libata/for-4.8.

Thanks.

-- 
tejun

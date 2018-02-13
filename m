From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: transport: cleanup documentation of sysfs
 interface
Date: Tue, 13 Feb 2018 06:39:05 -0800
Message-ID: <20180213143905.GL695913@devbig577.frc2.facebook.com>
References: <20180213112159.GA24306@mordor.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180213112159.GA24306@mordor.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Aishwarya Pant <aishpant@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>, Gwendal Grignou <gwendal@chromium.org>, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-ide@vger.kernel.org

On Tue, Feb 13, 2018 at 04:51:59PM +0530, Aishwarya Pant wrote:
> Clean-up the documentation of sysfs interfaces to be in the same format
> as described in Documentation/ABI/README. This will be useful for
> tracking changes in the ABI. Attributes are grouped by function (device,
> link or port) and then by date added.
> 
> This patch also adds documentation for one attribute -
> /sys/class/ata_port/ataX/port_no
> 
> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>

Applied to libata/for-4.16-fixes.

Thanks.

-- 
tejun

From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH resend] libata: blacklist Micron 500IT SSD with MU01
 firmware
Date: Mon, 21 May 2018 08:25:11 -0700
Message-ID: <20180521152511.GL1718769@devbig577.frc2.facebook.com>
References: <20180519212936.3155-1-sudip.mukherjee@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180519212936.3155-1-sudip.mukherjee@codethink.co.uk>
Sender: stable-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, "Martin K . Petersen" <martin.petersen@oracle.com>, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sat, May 19, 2018 at 10:29:36PM +0100, Sudip Mukherjee wrote:
> From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> 
> While whitelisting Micron M500DC drives, the tweaked blacklist entry
> enabled queued TRIM from M500IT variants also. But these do not support
> queued TRIM. And while using those SSDs with the latest kernel we have
> seen errors and even the partition table getting corrupted.

Applied to libata/for-4.17-fixes.

Thanks.

-- 
tejun

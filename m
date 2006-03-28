From: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: [PATCH 1/2] scsi: Add scsi_device max_cmd_len
Date: Tue, 28 Mar 2006 16:29:27 -0600
Message-ID: <1143584967.3353.47.camel@mulgrave.il.steeleye.com>
References: <200603282217.k2SMHJTH032251@d03av04.boulder.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <200603282217.k2SMHJTH032251@d03av04.boulder.ibm.com>
Sender: linux-scsi-owner@vger.kernel.org
To: Brian King <brking@us.ibm.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, 2006-03-28 at 16:17 -0600, Brian King wrote:
> Add a max_cmd_len field to the scsi_device struct
> to allow for per device limits of allowable command
> lengths. This will be used by libata, which is currently
> using the max_cmd_len field in the scsi_host struct,
> which doesn't work for attaching libata controlled
> SATA devices to SAS HBAs.

This really doesn't look correct.  What you want is a sata transport
class with a max command length in the host device.

James



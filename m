From: "Darrick J. Wong" <djwong@us.ibm.com>
Subject: Re: [PATCH] sd: implement stop_on_shutdown
Date: Fri, 19 Jan 2007 15:42:05 -0800
Message-ID: <45B1574D.1090502@us.ibm.com>
References: <20070119170122.GS10987@htj.dyndns.org>
Reply-To: "Darrick J. Wong" <djwong@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <20070119170122.GS10987@htj.dyndns.org>
Sender: linux-scsi-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: James.Bottomley@SteelEye.com, Jeff Garzik <jgarzik@pobox.com>, hmh@hmh.eng.br, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Tejun Heo wrote:
> sd doesn't stop (unload head) on shutdown.  This behavior is necessary
> for multi initiator cases.  Unloading head by powering off stresses
> the drive and sometimes produces distinct clunking noise which
> apparently disturbs users considering multiple reports on different
> distributions.  halt(8) usually puts the drives to sleep prior to
> shutdown but the implementation is fragile and it doesn't work with
> sleep-to-disk.

I wonder if this sort of thing (cache flush + spin down) is the sort of
thing that ought to be done to near-line storage at suspend time too,
though one would want allow_restart = 1 before doing such a thing.

--D

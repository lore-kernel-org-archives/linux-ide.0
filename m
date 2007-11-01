From: Tejun Heo <htejun@gmail.com>
Subject: Re: ATAPI devices in AHCI mode not working
Date: Thu, 01 Nov 2007 09:48:41 +0900
Message-ID: <47292269.7060205@gmail.com>
References: <39B20DF628532344BC7A2692CB6AEE0701EA6E7D@orsmsx420.amr.corp.intel.com><20071029203028.35645f26@the-village.bc.nu><39B20DF628532344BC7A2692CB6AEE0701EA6FBF@orsmsx420.amr.corp.intel.com> <20071029221332.1c9525a9@the-village.bc.nu> <39B20DF628532344BC7A2692CB6AEE0701EA70F4@orsmsx420.amr.corp.intel.com> <472837B4.3000109@gmail.com> <39B20DF628532344BC7A2692CB6AEE0701EE38E6@orsmsx420.amr.corp.intel.com> <39B20DF628532344BC7A2692CB6AEE0701EE3C42@orsmsx420.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:8782 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbXKAAss (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Oct 2007 20:48:48 -0400
Received: by rv-out-0910.google.com with SMTP id k20so295619rvb
        for <linux-ide@vger.kernel.org>; Wed, 31 Oct 2007 17:48:48 -0700 (PDT)
In-Reply-To: <39B20DF628532344BC7A2692CB6AEE0701EE3C42@orsmsx420.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Gaston, Jason D" <jason.d.gaston@intel.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Hello,

Gaston, Jason D wrote:
> Attached are the hdparm -I /dev/cdrom results for the three other drives
> I am using.  These do not include the original drive that had the major
> issues on, TSSTcorpCD/DVDW SH-S183L.
> 
> Applying the patch to the 2.6.24-rc kernel did not cause the same
> behavior, which I am seeing with older kernels.  Instead, everything
> seemed to be fine until I tried to automount the drive, which said that
> there was no media.  I was however, able to manually mount the drive.

Thanks.  Yeah, libata in SLE10SP1 can be considered ancient considering
the speed libata code has been evolving.  Please file a bug report in
bugzilla.novell.com and assign it to teheo@novell.com.  Eeeek... /me
hates vendor kernels.  :-)

Thanks.

-- 
tejun

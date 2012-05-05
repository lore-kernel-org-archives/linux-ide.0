From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 12/12] scsi_transport_sas: fix delete vs scan race
Date: Sat, 5 May 2012 14:52:38 -0700
Message-ID: <CAA9_cmcCQtyRBEt-c8EP6wuSukqZn0Mswxi3nDG7R-88L57BjA@mail.gmail.com>
References: <20120413233343.8025.18101.stgit@dwillia2-linux.jf.intel.com>
	<20120413233752.8025.97983.stgit@dwillia2-linux.jf.intel.com>
	<1335091115.13208.14.camel@dabdike.lan>
	<CABE8wwssa-_MsCTe0FJeCLY5KTk1sRcsmUjF8Sb-5sofc=zuFQ@mail.gmail.com>
	<1335114924.13208.27.camel@dabdike.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:60844 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207Ab2EEVwj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 May 2012 17:52:39 -0400
In-Reply-To: <1335114924.13208.27.camel@dabdike.lan>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org

On Sun, Apr 22, 2012 at 10:15 AM, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> Async scan here means any scan in a different thread, right ... it ju=
st
> has to be asynchronous relative to us? =A0So that includes the manual=
ly
> initiated ones and hotplug ones, doesn't it?

[ resend since I notice this never hit the lists ]

Hmm, well no I don't think so.  This literally means the initial async
scan, and the
failure window is between when we skip the call to
scsi_sysfs_add_sdev() (in scsi_add_lun() under the scan_mutex) and
finally call scsi_sysfs_add_sdev() again via scsi_finish_async_scan().
I don't see how that fixes it because when we fail the sequence goes:

mutex_lock(scan_mutex)
starget->parent =3D end_device;
scsi_add_lun()
mutex_unlock(scan_mutex)

device_del(end_device)

mutex_lock(scan_mutex)
device_add(starget)
<crash>

As far as I can see taking the scan_mutex in sas_rphy_remove() does
not change this failure window.  Unless I missed something?

I am going to re-submit this patch as is with the proposed libsas batch=
 for 3.5.

--
Dan

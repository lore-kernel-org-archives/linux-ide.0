From: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [libsas PATCH v12 04/11] sysfs: handle 'parent deleted before
 child added'
Date: Thu, 22 Mar 2012 16:11:18 -0700
Message-ID: <CABE8wwskNT7C65rsSiS_9bVf9+-ep6EyviBit7+y3hnt5c8Omw@mail.gmail.com>
References: <20120322063127.22036.23206.stgit@dwillia2-linux.jf.intel.com>
	<20120322063214.22036.77957.stgit@dwillia2-linux.jf.intel.com>
	<20120322143959.GF19835@kroah.com>
	<CABE8wwtyxJaSfZREKRLDTZEef3nk=b+RFSe9i_UmV9knbQJ-tg@mail.gmail.com>
	<20120322235133.269b74b8@stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <20120322235133.269b74b8@stein>
Sender: linux-scsi-owner@vger.kernel.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, Mar 22, 2012 at 3:51 PM, Stefan Richter
<stefanr@s5r6.in-berlin.de> wrote:
> Isn't this something which is to be accomplished by counting references to
> the parent device?

As I mentioned to James [1] the reference count keeps the parent from
being kfree()'d but not device_del()'d where kobj->sd gets sets to
NULL.

--
Dan

[1]: http://marc.info/?l=linux-scsi&m=133243414518064&w=2

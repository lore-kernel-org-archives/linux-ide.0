From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v5 3/3] scsi: async sd resume
Date: Fri, 14 Mar 2014 13:11:10 -0700
Message-ID: <CAPcyv4iVMss=Vj8O9RR2GGCw-4uesw1MKj-qFuaXZqtTz1Cqdg@mail.gmail.com>
References: <Pine.LNX.4.44L0.1403101658490.5966-100000@netrider.rowland.org>
	<1394511589.2142.5.camel@dabdike.int.hansenpartnership.com>
	<CAPcyv4gJssEE7hADEDXmi4ao031uSVjMenKk9AFcbTukm1MKNg@mail.gmail.com>
	<1394515014.2142.11.camel@dabdike.int.hansenpartnership.com>
	<CAPcyv4gLEQ9-e2GJpfbQQ+DN+nsv-90oFwXxh-_K_hU0z4U5YQ@mail.gmail.com>
	<1394519379.2142.13.camel@dabdike.int.hansenpartnership.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <1394519379.2142.13.camel@dabdike.int.hansenpartnership.com>
Sender: linux-scsi-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Tejun Heo <tj@kernel.org>, Len Brown <len.brown@intel.com>, linux-scsi <linux-scsi@vger.kernel.org>, Phillip Susi <psusi@ubuntu.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Todd Brandt <todd.e.brandt@linux.intel.com>
List-Id: linux-ide@vger.kernel.org

On Mon, Mar 10, 2014 at 11:29 PM, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>> > In the long game, though this whole debate is moot: setups with hard
>> > wired start times adhere to them regardless of what the system does, so
>> > they ignore start unit commands.  Systems without hard wired start times
>> > can usually be started at once, so us introducing a delay is unnecessary
>> > in either case.
>>
>> Ok, then I'll let the patch stand as is.
>
> Sounds good.
>
> James
>
>

Well, one more chirp about this.  If the user has disabled async
scanning by CONFIG_SCSI_SCAN_ASYNC=n or scsi_mod.scan != "async" then
resume should follow suit.  I'll include this in the next rev.

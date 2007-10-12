From: Bruce Allen <ballen@gravity.phys.uwm.edu>
Subject: Re: [smartmontools-devel] smartd causing
 SATA timeouts on sleeping drives
Date: Fri, 12 Oct 2007 04:15:13 -0500 (CDT)
Message-ID: <Pine.LNX.4.63.0710120413390.15956@trinity.phys.uwm.edu>
References: <76366b180710051838h11c63c38o9a4248309ff9ee7d@mail.gmail.com>
	<4707ECF0.9030800@gmail.com>
	<76366b180710072251i7af01faaqc18776d8f8f31ef9@mail.gmail.com>
	<4709C8D6.3020008@gmail.com>
	<76366b180710072332o159d2364i6fe5e0d5e28c0944@mail.gmail.com>
	<Pine.LNX.4.63.0710101435340.4797@trinity.phys.uwm.edu>
	<470D843B.3030405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <smartmontools-support-bounces@lists.sourceforge.net>
In-Reply-To: <470D843B.3030405@gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/smartmontools-support>,
	<mailto:smartmontools-support-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=smartmontools-support>
List-Post: <mailto:smartmontools-support@lists.sourceforge.net>
List-Help: <mailto:smartmontools-support-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/smartmontools-support>,
	<mailto:smartmontools-support-request@lists.sourceforge.net?subject=subscribe>
Sender: smartmontools-support-bounces@lists.sourceforge.net
Errors-To: smartmontools-support-bounces@lists.sourceforge.net
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Smartmontools Developers List <smartmontools-devel@lists.sourceforge.net>, Smartmontools Mailing List <smartmontools-support@lists.sourceforge.net>, Andrew Paprocki <andrew@ishiboo.com>
List-Id: linux-ide@vger.kernel.org

>> Hmm, it sounds as if smartmontools should send a SRST to spin up the
>> drive, but I do not know enough to be sure.
>
> Eh... Now that I think about it.  I don't think there's a way to work
> around this from userland.  smartmontools doesn't know the current power
> mode (sleeping drive doesn't even respond to CHECK POWER MODE), so it
> can't determine whether the device needs SRST or not and issuing SRST
> unconditionally would cause a lot more problems.

OK, makes sense.

> Maybe what should be done is to track sleep mode in libata and issue 
> SRST automatically if a command is issued to a sleeping drive.  I'll 
> work on it.

Thank you!

>> Could I add you to the developers list and give you CVS write access? 
>> This might make it easier for you to fix the various little 
>> smartmontools problems like this that keep cropping up!  Just fixing 
>> the code might be a lot faster than explaining it and sending 
>> patches...
>>
>> If this is OK with you, please send me your sourceforge username, and 
>> I'll add you to the developers list.
>
> I'll stay chicken for the time being and only send patches.  :-)

I was really really hoping you would say 'yes'. Oh well...

Cheers,
 	Bruce


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
